FROM ubuntu:20.10

RUN apt-get update --yes \
 && apt-get install --yes --no-install-recommends \
    wget ca-certificates \
 && rm -rf /var/lib/apt/lists/*

ADD installer.sh /installer.sh
ENV INSTALL_DIR=/miniconda3

SHELL ["/bin/bash", "-c"]

RUN source /installer.sh \
 && find ${HOME} -maxdepth 1 -type d -name ".*" -exec rm -rf {} \; \
 && conda list -e > /requirements.txt

RUN echo '#!/bin/bash' > /conda.sh \
 && echo 'source ${INSTALL_DIR}/etc/profile.d/conda.sh && conda activate base && "$@"' >> /conda.sh \
 && chmod +x /conda.sh

SHELL ["/bin/sh", "-c"]

ARG TINI_VERSION=v0.19.0
RUN wget https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini --quiet -O /tini \
 && chmod +x /tini

ENTRYPOINT ["/tini", "-s", "--", "/conda.sh"]

