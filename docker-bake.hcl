group "default" {
    targets = [
        "chromium",
        "chrome",
    ]
}
target "chromium" {
    platforms = [
        "linux/amd64",
        "linux/arm64",
    ]
    args = {
        SOURCE_IMAGE = "quay.io/inviqa_images/chromium:latest",
        CHROME_PATH = "/usr/bin/chromium-browser",
    }
    tags = [
        "quay.io/inviqa_images/lighthouse:chromium"
    ]
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
