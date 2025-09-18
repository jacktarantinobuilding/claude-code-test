# Code Formatting Script (PowerShell)
# Automatically formats all code in the project

$ErrorActionPreference = "Stop"

Write-Host "🎨 Formatting code..." -ForegroundColor Cyan
Write-Host

# Check if we're in the right directory
if (-not (Test-Path "pyproject.toml")) {
    Write-Host "❌ Error: pyproject.toml not found. Please run from project root." -ForegroundColor Red
    exit 1
}

Write-Host "🔤 Sorting imports with isort..." -ForegroundColor Yellow
uv run isort .

Write-Host "🖤 Formatting code with black..." -ForegroundColor Yellow
uv run black .

Write-Host "📋 Running ruff auto-fixes..." -ForegroundColor Yellow
uv run ruff check --fix .

Write-Host
Write-Host "✅ Code formatting complete!" -ForegroundColor Green