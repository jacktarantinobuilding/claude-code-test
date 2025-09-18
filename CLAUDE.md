# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Running the Application

**Start the application:**
```bash
# Quick start using provided script
chmod +x run.sh
./run.sh

# Manual start (alternative)
cd backend
uv run uvicorn app:app --reload --port 8000
```

**Dependencies:**
```bash
# Install dependencies
uv sync
```

**Environment setup:**
- Create `.env` file with `ANTHROPIC_API_KEY=your_key_here`
- Python 3.13+ required
- Windows users: Use Git Bash for commands

## Architecture Overview

This is a RAG (Retrieval-Augmented Generation) system for course materials with the following architecture:

### Core Components

- **RAGSystem** (`rag_system.py`): Main orchestrator that coordinates all components
- **DocumentProcessor** (`document_processor.py`): Processes PDF/DOCX/TXT files into Course/Lesson objects and chunks
- **VectorStore** (`vector_store.py`): ChromaDB wrapper for semantic search and storage
- **AIGenerator** (`ai_generator.py`): Anthropic Claude integration with tool calling support
- **SessionManager** (`session_manager.py`): Manages conversation history per session
- **ToolManager** (`search_tools.py`): Provides search tools for AI to query course content

### Data Flow

1. Documents in `docs/` folder are processed into Course/Lesson objects
2. Content is chunked and stored in ChromaDB with embeddings
3. User queries trigger AI generation with search tool access
4. AI can call CourseSearchTool to find relevant content
5. Responses are generated using retrieved context and conversation history

### API Structure

- **FastAPI backend** (`app.py`):
  - `/api/query` - Main query endpoint
  - `/api/courses` - Course statistics
  - Static file serving for frontend
- **Frontend**: Simple HTML/CSS/JS interface in `frontend/`

### Key Configuration

- Model: `claude-sonnet-4-20250514`
- Embedding: `all-MiniLM-L6-v2`
- Chunk size: 800 chars with 100 char overlap
- Max search results: 5
- ChromaDB storage: `./chroma_db`

## Development Notes

- Uses `uv` for Python package management
- ChromaDB auto-initializes on startup
- Documents auto-load from `../docs` on startup
- No-cache headers set for development static files
- Session-based conversation history (max 2 exchanges)

## Code Quality Tools

The project includes essential code quality tools:

- **black**: Code formatter for consistent style
- **ruff**: Fast linter for error detection and code improvements
- **mypy**: Type checker for Python
- **isort**: Import sorter

**Quick commands:**
```bash
# Install dev dependencies
uv sync --group dev

# Format code
make format
# or manually:
uv run black .
uv run isort .
uv run ruff check --fix .

# Run quality checks
make check
# or manually:
uv run ruff check .
uv run black --check --diff .
uv run isort --check-only --diff .
uv run mypy backend/ main.py

# Individual tools
make lint        # Run ruff linter
make type-check  # Run mypy
```

**Scripts available:**
- `scripts/format-code.sh` / `scripts/format-code.ps1` - Auto-format code
- `scripts/quality-check.sh` / `scripts/quality-check.ps1` - Run all quality checks