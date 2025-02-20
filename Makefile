# Default environment
APP_ENV ?= dev

# Python command to use
PYTHON := python

# Server configurations based on environment
ifeq ($(APP_ENV),dev)
	HOST := localhost
	PORT := 8000
	LOG_LEVEL := debug
else ifeq ($(APP_ENV),stage)
	HOST := 0.0.0.0
	PORT := 8080
	LOG_LEVEL := info
else ifeq ($(APP_ENV),prod)
	HOST := 0.0.0.0
	PORT := 80
	LOG_LEVEL := warning
endif

# Target to run the server
run:
	@echo "Starting server in $(APP_ENV) mode..."
	APP_ENV=$(APP_ENV) uvicorn main:app --host $(HOST) --port $(PORT) --log-level $(LOG_LEVEL) $(if $(filter $(APP_ENV),dev),--reload,)

# Target to install dependencies
install:
	@echo "Installing dependencies..."
	pip install -r requirements.txt

# Target to clean Python cache files
clean:
	@echo "Cleaning up..."
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	find . -type f -name ".coverage" -delete
	find . -type d -name ".pytest_cache" -exec rm -rf {} +

# Target to run tests
test:
	@echo "Running tests..."
	python -m pytest

# Target to run linting
lint:
	@echo "Running linter..."
	flake8 .
	black --check .

.PHONY: run install clean test lint
