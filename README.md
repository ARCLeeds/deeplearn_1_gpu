## Basic Deep Learning Docker container

* GNU compilers
* OpenBLAS
* Anaconda 3
* Jupyter Notebook
* Theano
* Tensorflow
* Keras

with GPU optimisation. Run in singularity using the --nv flag to bind in Nvidia drivers etc.

An additional directory, `opt/notebooks` exists within the container that contains a couple of starter datasets
from the UCI Machine Learning Repository:

1. The Pima Indians Diabetes Data Set
[https://archive.ics.uci.edu/ml/datasets/Pima+Indians+Diabetes](https://archive.ics.uci.edu/ml/datasets/Pima+Indians+Diabetes)

2. Ionosphere Data Set
[https://archive.ics.uci.edu/ml/datasets/Ionosphere](https://archive.ics.uci.edu/ml/datasets/Ionosphere)


Once cloned via `git clone` and assuming Docker is installed locally, it can first be built:

1. cd into the ds_1 directory
2. Build: `docker build -t ds1 .`

And then run:

`docker run -i -t ds1`

Which will give a command prompt similar to: `root@08c49228db87:/#`. Use `exit` to leave the container environment.

Python, C/C++ and Fortran code will run as normal within the container.

Docker containers are intended to be ephemeral, directories and files can be created inside the container but they are not permanent. 
All changes are lost when exiting from the container.

To attach external directories (the recommended use-case where you need to save and load files from elsewhere):

`docker run -v $HOME:/home -i -t ds1`

This will mount the external user home directory (`$HOME`) to the local mount point `/home` within the container. 
Files can be saved to and loaded from this directory. Multiple external directories can be added to the container by using multiple `-v` clauses.

This container also contains a Jupyter notebook server. This can be launched when the container starts and an external directory mounted at the same time:

~~~
docker run -v $HOME:/home -i -t -p 8888:8888 ds1 /bin/bash \ 
-c "/opt/conda/bin/jupyter notebook --notebook-dir=/home --ip='*' --port=8888 --no-browser"
~~~

To use, launch a Web browser and point to `http://localhost:8888`

When finished, the notebook server can be closed with `[CTRL] C`


