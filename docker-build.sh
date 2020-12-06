#!/usr/bin/env bash

# Build country level docker image

set -o errexit

# FC_COUNTRY is read from .env
image=fc-agents-${FC_COUNTRY}:latest

docker build \
  --file docker/Dockerfile \
  --build-arg FC_COUNTRY="${FC_COUNTRY}" \
  --tag "${image}" \
  .
