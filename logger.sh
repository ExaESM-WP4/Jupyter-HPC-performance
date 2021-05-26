#!/bin/bash

INTERVAL=3600

LOGS_DIR=morpheus_logs
mkdir -p ${LOGS_DIR}

# https://stackoverflow.com/a/61643945
while sleep $(echo ${INTERVAL}-`date "+%s"`%${INTERVAL} | bc); do
 MODE=1 INSTALL_DIR=$PWD bash starter.sh > ${LOGS_DIR}/conda-$(date +%Y%m%d%H%M%S).log 2>&1
 MODE=2 bash starter.sh > ${LOGS_DIR}/singularity-$(date +%Y%m%d%H%M%S).log 2>&1
done

