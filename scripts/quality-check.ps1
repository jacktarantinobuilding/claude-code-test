# Code Quality Check Script (PowerShell)
# Runs all quality checks for the project

$ErrorActionPreference = "Stop"

Write-Host "🧹 Running code quality checks..." -ForegroundColor Cyan
Write-Host

# Check if we're in the right directory
if (-not (Test-Path "pyproject.toml")) {
    Write-Host "❌ Error: pyproject.toml not found. Please run from project root." -ForegroundColor Red
    exit 1
}

Write-Host "📋 Running ruff linter..." -ForegroundColor Yellow
uv run ruff check .

Write-Host
Write-Host "🎨 Running black formatter check..." -ForegroundColor Yellow
uv run black --check --diff .

Write-Host
Write-Host "🔤 Running isort import sorting check..." -ForegroundColor Yellow
uv run isort --check-only --diff .

Write-Host
Write-Host "🔍 Running mypy type checking..." -ForegroundColor Yellow
uv run mypy backend/ main.py

Write-Host
Write-Host "✅ All quality checks passed!" -ForegroundColor Green