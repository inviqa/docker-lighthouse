# hadolint ignore=DL3007
FROM yukinying/chrome-headless-browser:latest

USER root

RUN sed -i 's/stable/buster/g' /etc/apt/sources.list \
 && apt-get update -qq \
 && apt-get --no-install-recommends -qq install -y \
   bc \
   curl \
   jq \
 # clean \
 && apt-get auto-remove -qq -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

USER headless
ENV NVM_DIR /home/headless/.nvm
RUN cd /home/headless \
 && mkdir .nvm \
 && curl -o /tmp/nvm-install.sh https://raw.githubusercontent.com/creationix/nvm/v0.37.2/install.sh \
 && bash /tmp/nvm-install.sh \
 && rm /tmp/nvm-install.sh \
 && . /home/headless/.nvm/nvm.sh \
 && nvm install v15 \
 && npm install -g lighthouse \
 && npm cache clean --force

COPY root  /

ENTRYPOINT ["/usr/bin/dumb-init", "--", "/bin/bash", "-i", "/app/run.sh"]
