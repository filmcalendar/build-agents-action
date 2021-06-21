# build-agents-action

## Configuration

**Action inputs**

|                           | default       |
| ------------------------- | ------------- |
| `country`                 |               |
| `dockerRegistryPassword`  |               |
| `dockerRegistry`          | ghcr.io       |
| `dockerImageOwner`        | filmcalendar  |
| `dockerImageName`         | fc-agents     |

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
      - nam: Build docker image
        uses: filmcalendar/build-agents-action@v1
        with:
          country: uk
          dockerRegistryPassword: ${{ secrets.GH_TOKEN }}
```

## Contribute

Contributions are always welcome!

## License

MIT
