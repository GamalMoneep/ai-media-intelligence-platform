# AI-Powered Media Intelligence Platform

A comprehensive Python service that downloads, transcribes, translates, and summarizes both audio and video content using advanced Whisper ML models and LLM-based summarization.
## Features

- Download and process individual media files (audio/video) or entire feeds
- Automatic content title extraction from webpage metadata
- Transcribe audio and video content using MLX Whisper (with automatic model download)
- Generate comprehensive summaries using advanced LLM models
- Track processed content to avoid duplicates
- Multiple summary formats (key ideas, concepts, quotes, etc.)
- Multi-language support for transcription and translation
- Command-line interface for easy management
- Secure API key management using environment variables
- FastAPI-based REST API for programmatic access

## Project Structure

```
ai-media-intelligence-platform/
├── config/               # Configuration settings
├── src/                 # Source code
│   ├── main/           # Core functionality
│   ├── summarizer/     # Summary generation
│   ├── utils/         # Utility functions
│   └── api/           # FastAPI REST endpoints
├── data/               # Data storage
│   ├── downloads/     # Downloaded media files
│   ├── transcripts/   # Generated transcripts
│   └── summaries/     # Generated summaries
├── static/            # Web interface files
├── scripts/           # Utility scripts
└── tests/             # Test files
```


## Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/GamalMoneep/ai-media-intelligence-platform.git
   cd ai-media-intelligence-platform
   ```

2. Create and activate conda environment:
   ```bash
   conda create -n media_intelligence python=3.11 numpy=1.24 numba -y
   conda activate media_intelligence
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Set up environment variables:
   ```bash
   # Run the interactive setup script
   python scripts/setup_dev.py
   ```

5. Start the FastAPI server:
   ```bash
   uvicorn src.api.app:app --reload
   ```
    The API will be available at `http://localhost:8000`



## Available Whisper Models

The following pre-trained models are available from MLX Hub:

- `tiny`: Smallest model, fastest but less accurate
- `base`: Good balance of speed and accuracy for simple tasks
- `small`: Better accuracy than base, still relatively fast
- `medium`: Good accuracy for most use cases
- `large`: Best accuracy, slower processing
- `large-v2`: Improved version of large model
- `large-v3`: Latest and most accurate model

You can specify the model in three ways:
1. Use a model name (e.g., `large-v3`)
2. Provide a path to a local model directory
3. Specify a custom MLX Hub model path



## Environment Variables

The following environment variables can be configured in your `.env` file:

- `OPENAI_API_KEY` (required): Your OpenAI API key
- `WHISPER_MODEL_PATH`: Model name or path (e.g., 'large-v3' or '/path/to/model')
- `LLM_MODEL` (optional): LLM model to use (default: gpt-4)
- `LLM_MAX_TOKENS` (optional): Maximum tokens for LLM (default: 4096)
- `LLM_TEMPERATURE` (optional): LLM temperature setting (default: 0.8)



### Output Structure

The service organizes outputs in the `data` directory:
- `downloads/`: Contains downloaded media files (audio/video)
- `transcripts/`: Contains content transcripts
- `summaries/`: Contains generated summaries in different formats:
  - `key_ideas.md`: Main points from the content
  - `concepts.md`: Detailed concept breakdown
  - `quotes.md`: Notable quotes
  - `actionable_items.md`: Action items and takeaways
  - `experimental.md`: Experimental summary format



## Python API Usage

You can also use the service programmatically:

```python
from src.main.podcast_fetcher import PodcastFetcher, PodcastEpisode
from src.main.audio_processor import AudioProcessor
from src.main.transcriber import Transcriber
from src.summarizer.summarizer import Summarizer
from datetime import datetime

# Initialize with specific model
transcriber = Transcriber(model_path='large-v3')  # Will download if needed

# Process a single media file
episode = PodcastEpisode(
    title="Media Content Title",
    url="https://example.com/content.mp4",  # Supports both audio and video
    published_date=datetime.now(),
    description="",
    podcast_name="Direct URL"
)

processor = AudioProcessor()
summarizer = Summarizer()

# Process the media content
media_path = processor.download_episode(episode)
transcription = transcriber.transcribe(media_path)
summary = summarizer.generate_summary(transcription['text'])
summarizer.save_summary(summary, media_path.stem)


# Or process multiple media files from feeds
fetcher = PodcastFetcher()
episodes = fetcher.get_latest_episodes(['feed_url1', 'feed_url2'])
media_paths = processor.download_episodes(episodes)
transcriptions = transcriber.transcribe_multiple(media_paths)

for trans in transcriptions:
    summary = summarizer.generate_summary(trans['text'])
    summarizer.save_summary(summary, trans['media_path'].stem)
```



## Security Notes

1. Never commit your `.env` file to version control
2. Keep your API keys secure and rotate them regularly
3. The `.gitignore` file is configured to exclude sensitive files
4. Use environment variables for all sensitive information



## Dependencies

- feedparser: RSS feed parsing
- yt-dlp: Media download (audio/video)
- mlx-whisper: Audio/video transcription
- langchain: LLM integration
- openai: OpenAI API client
- python-dotenv: Environment variable management
- beautifulsoup4: HTML parsing for title extraction
- requests: HTTP client for webpage fetching
- fastapi: REST API framework
- uvicorn: ASGI server



## API Usage

The service provides a FastAPI-based REST API for managing media content and processing audio/video files:

### API Endpoints

1. Access the interactive API documentation:
   ```
   http://localhost:8000/docs
   ```
   This provides a Swagger UI interface to test all available endpoints.

2. Alternative API documentation:
   ```
   http://localhost:8000/redoc
   ```
   This provides a ReDoc interface for API documentation.

