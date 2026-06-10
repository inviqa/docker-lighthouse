group "default" {
    targets = [
        "chromium-bookworm",
        "chromium-trixie",
        "chrome",
    ]
}

target "chromium-bookworm" {
    platforms = [
        "linux/amd64",
        "linux/arm64",
    ]
    args = {
        SOURCE_IMAGE = "quay.io/inviqa_images/chromium:bookworm",
        CHROME_PATH = "/usr/bin/chromium",
    }
    tags = [
        "quay.io/inviqa_images/lighthouse:chromium-bookworm"
    ]
}

target "chromium-trixie" {
    platforms = [
        "linux/amd64",
        "linux/arm64",
    ]
    args = {
        SOURCE_IMAGE = "quay.io/inviqa_images/chromium:trixie",
        CHROME_PATH = "/usr/bin/chromium",
    }
    tags = [
        "quay.io/inviqa_images/lighthouse:chromium",
        "quay.io/inviqa_images/lighthouse:chromium-trixie"
    ]
}

target "chromium" {
    inherits = ["chromium-trixie"]
}

target "chrome" {
    platforms = [
        "linux/amd64"
    ]
    args = {
        SOURCE_IMAGE = "yukinying/chrome-headless-browser:latest",
        CHROME_PATH = "/usr/bin/google-chrome",
    }
    tags = [
        "quay.io/inviqa_images/lighthouse:latest",
        "quay.io/inviqa_images/lighthouse:chrome",
    ]
}
