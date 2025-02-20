# szybko
Yet purposeless Python Fast API webserver

Shows a health message at /health

---
```sh
virtualenv venv
source venv/bin/activate
make install

# Run in dev mode (default)
make run

# Run in staging mode
APP_ENV=stage make run

# Run in production mode
APP_ENV=prod make run
```
