#!/bin/bash

INTERVAL=3600

function nesh_experiments {
 MODE=2 IMAGE_DIR=/gxfs_home/geomar/smomw260/jupyter.sif bash starter.sh > ${LOGS_DIR}/singularity-home-$(date +%Y%m%d%H%M%S).log 2>&1
 MODE=2 IMAGE_DIR=/gxfs_work1/geomar/smomw260/jupyter.sif bash starter.sh > ${LOGS_DIR}/singularity-work-$(date +%Y%m%d%H%M%S).log 2>&1
 MODE=1 INSTALL_DIR=/gxfs_home/geomar/smomw260/miniconda3 bash starter.sh > ${LOGS_DIR}/conda-home-$(date +%Y%m%d%H%M%S).log 2>&1
 MODE=1 INSTALL_DIR=/gxfs_work1/geomar/smomw260/miniconda3 bash starter.sh > ${LOGS_DIR}/conda-work-$(date +%Y%m%d%H%M%S).log 2>&1
}

LOGS_DIR=$PWD/nesh-fe3_logs
mkdir -p ${LOGS_DIR}

while sleep $(echo ${INTERVAL}-`date "+%s"`%${INTERVAL} | bc); do
 nesh_experiments
done

#
# References
# https://stackoverflow.com/a/61643945
#

