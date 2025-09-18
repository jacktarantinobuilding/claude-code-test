.PHONY: help install format check lint type-check clean

help: ## Show this help message
	@echo "Available commands:"
	@echo
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

install: ## Install dependencies including dev tools
	uv sync --group dev

format: ## Format code with black and isort, apply ruff fixes
	uv run isort .
	uv run black .
	uv run ruff check --fix .

check: ## Run all quality checks (format, lint, type-check)
	uv run ruff check .
	uv run black --check --diff .
	uv run isort --check-only --diff .
	uv run mypy backend/ main.py

lint: ## Run ruff linter
	uv run ruff check .

type-check: ## Run mypy type checking
	uv run mypy backend/ main.py

clean: ## Clean up temporary files and caches
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".mypy_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".ruff_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -name "*.pyc" -delete 2>/dev/null || true

run: ## Start the application
	chmod +x run.sh && ./run.sh