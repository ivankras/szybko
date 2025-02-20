import os
from fastapi import FastAPI

# Get environment from ENV variable
APP_ENV = os.getenv("APP_ENV", "dev")

# Create FastAPI app with environment-specific configuration
app = FastAPI(
    title="MyAPI",
    description=f"Running in {APP_ENV} environment",
    version="0.1.0",
    docs_url=None if APP_ENV == "prod" else "/docs",
    redoc_url=None if APP_ENV == "prod" else "/redoc",
)

@app.get("/")
async def root():
    return {
        "message": f"Hello from {APP_ENV} environment",
        "environment": APP_ENV
    }

@app.get("/health")
async def health_check():
    return {"status": "healthy", "environment": APP_ENV}


# Environment-specific routes
if APP_ENV != "prod":
    @app.get("/debug")
    async def debug_info():
        return {"debug": "information", "environment": APP_ENV}
