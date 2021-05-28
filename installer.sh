#!/bin/bash

if [ -z "${INSTALL_DIR}" ]; then echo "INSTALL_DIR is not set... exiting."; exit; fi

MINICONDA_VERSION=Miniconda3-py39_4.9.2-Linux-x86_64.sh
wget https://repo.anaconda.com/miniconda/${MINICONDA_VERSION} --quiet
bash ${MINICONDA_VERSION} -f -b -p ${INSTALL_DIR} && rm -rf ${MINICONDA_VERSION}

source ${INSTALL_DIR}/etc/profile.d/conda.sh && conda activate base

if [ -f requirements.txt ]; then
 conda install -n base -c conda-forge --file requirements.txt --yes
else
 conda install -n base -c conda-forge jupyterlab pandas matplotlib --yes
fi

${INSTALL_DIR}/bin/conda clean --all --yes

