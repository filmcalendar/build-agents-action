# build-country-agents-action

## Usage

```yaml
name: Release
on:
  push:
    branches:
      - main

jobs:
  publish:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - id: dotenv
        uses: falti/dotenv-action@v0.2.5
      - nam: Build docker image
        uses: filmcalendar/build-country-agents-action@v1
        with:
          fc-country: ${{ steps.dotenv.outputs.FC_COUNTRY }}
          docker-registry-password: ${{ steps.dotenv.outputs.FC_DOCKER_REGISTRY_PASSWORD }}
```

## Contribute

Contributions are always welcome!

## License

MIT
