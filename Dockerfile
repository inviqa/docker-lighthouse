# syntax=docker/dockerfile:1.3-labs
ARG SOURCE_IMAGE
FROM ${SOURCE_IMAGE}

USER root

RUN apt-get update -qq \
 && apt-get --no-install-recommends -qq install -y \
   bc \
   curl \
   jq \
 # clean \
 && apt-get auto-remove -qq -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

USER headless
ARG CHROME_PATH
ENV CHROME_PATH=${CHROME_PATH}

ENV NVM_DIR /home/headless/.nvm
RUN bash <<EOF
  set -o errexit -o nounset -o pipefail
  cd /home/headless
  touch .bashrc
  mkdir .nvm
  curl -o /tmp/nvm-install.sh https://raw.githubusercontent.com/creationix/nvm/v0.37.2/install.sh
  bash /tmp/nvm-install.sh
  rm /tmp/nvm-install.sh
  . /home/headless/.nvm/nvm.sh
  nvm install v15
  npm install -g lighthouse
  npm cache clean --force
EOF

COPY root  /

ENTRYPOINT ["/usr/bin/dumb-init", "--", "/bin/bash", "-i", "/app/run.sh"]
