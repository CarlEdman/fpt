FROM ghcr.io/astral-sh/uv:alpine
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Copy the project into the image
COPY . /app

# Disable development dependencies
ENV UV_NO_DEV=1

ENV FPT_HOST=0.0.0.0
ENV FPT_PORT=7777

# Sync the project into a new environment, asserting the lockfile is up to date
WORKDIR /app
RUN uv sync --locked

EXPOSE 7777

CMD ["uv", "run", "src/server.py"]
