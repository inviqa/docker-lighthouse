# Lighthouse Command Line Docker Image

Save time in projects that use [harness-base-php] by pre-installing the Lighthouse CLI.

## Contents

- [Supported Versions](#supported-versions)
- [Build](#build)
- [Run](#run)

## Supported Versions

| Browser variant | Bookworm | Trixie | Chrome |
| --------------- | -------- | ------ | ------ |
| `chromium`      | x        | x      |        |
| `chrome`        |          |        | x      |

`chromium` is an alias for `chromium-trixie`.
`latest` is an alias for `chrome`.

## Build

Print the build matrix:

```bash
docker buildx bake --print
```

Build all variants:

```bash
docker buildx bake
```

Build the current Chromium variant:

```bash
docker buildx bake chromium-trixie
```

## Run

```bash
docker run --rm quay.io/inviqa_images/lighthouse:chromium-trixie https://example.com
```

[harness-base-php]: https://github.com/inviqa/harness-base-php
