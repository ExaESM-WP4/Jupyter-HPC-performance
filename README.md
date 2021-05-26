# jupyter-hpc-performance

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
$ INSTALL_DIR=$PWD/miniconda3 bash installer.sh
```

Run logging,

```
$ nohup timeout 1d bash logger.sh &
```

