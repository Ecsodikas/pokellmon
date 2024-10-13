FROM ubuntu:latest

COPY ./run.sh /app/run.sh

RUN apt-get update && apt-get install -y \
curl

RUN curl -fsSL https://ollama.com/install.sh | sh

RUN chmod +x /app/run.sh

ENTRYPOINT ["/app/run.sh"]
