# Jupyter HPC performance

This is a quick project that quantifies the start-up performance of a particular JupyterLab environment across several machines, including a desktop computer, a shared workstation and two high-performance computing systems.
The distributed storage infrastructure at HPC systems is often optimized for high throughput I/O rather than low latency I/O.
Especially during times with already high metadata load, the overhead associated with reading and writing operations on lots of small files can become a major bottleneck and very long JupyterLab and/or Jupyter kernel environment start-up times might be experienced.

The intention here was to illustrate the usefulness of containerized Jupyter environments especially on those systems that rely on distributed storage infrastructure.
A quick analysis of Jupyter start-up time characteristics across several machines is shown in the Jupyter notebook [here](./analysis.ipynb).

## Deploy logging

Docker build,

```
$ docker build -t local/jupyter-hpc-performance .
```

Export environment,

```
$ docker run --rm -v $PWD:/output local/jupyter-hpc-performance cp /requirements.txt /output
```

Singularity convert,

```
$ docker pull kathoef/docker2singularity:latest
$ docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v ${PWD}:/output \
kathoef/docker2singularity singularity build jupyter.sif docker-daemon://local/jupyter-hpc-performance:latest
```

Install miniconda3,

```
$ INSTALL_DIR=/p/project/cesmtst/hoeflich1/miniconda3 bash installer.sh
```

Specify start-up experiments in logger.sh,

```
function juwels_experiments {
 MODE=2 IMAGE_DIR=/p/project/cesmtst/hoeflich1/jupyter.sif bash starter.sh > ${LOGS_DIR}/singularity-$(date +%Y%m%d%H%M%S).log 2>&1
 MODE=1 INSTALL_DIR=/p/project/cesmtst/hoeflich1/miniconda3 bash starter.sh > ${LOGS_DIR}/conda-$(date +%Y%m%d%H%M%S).log 2>&1
}
```

Run logging,

```
$ nohup timeout 1d bash logger.sh &
```
