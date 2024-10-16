#!/usr/bin/env sh

ollama serve &

sleep 5

ollama run llava-phi3
