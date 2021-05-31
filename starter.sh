#!/bin/bash

export TIME="%E; %M; %K; %Z; %F; %R; %W; %c; %w; %I; %O; %r; %s; %x"

if [ "$MODE" == "1" ]; then

if [ -z "${INSTALL_DIR}" ]; then echo "INSTALL_DIR not provided... exiting."; exit; fi

hostname
date +%F_%T_%N
#/usr/bin/time 
bash -c "source ${INSTALL_DIR}/etc/profile.d/conda.sh && conda activate base && \
jupyter lab --no-browser --ServerApp.shutdown_no_activity_timeout=60"
date +%F_%T_%N

elif [ "$MODE" == "2" ]; then

if [ -z "${IMAGE_DIR}" ]; then echo "IMAGE_DIR not provided... exiting."; exit; fi
#module load singularity/3.6.4

hostname
date +%F_%T_%N
#/usr/bin/time 
bash -c "singularity run ${IMAGE_DIR} jupyter lab --no-browser --ServerApp.shutdown_no_activity_timeout=60"
date +%F_%T_%N

fi

#hostname; cat /etc/*release; uname -a
#singularity --version
#/usr/bin/time --version
#uptime; free

