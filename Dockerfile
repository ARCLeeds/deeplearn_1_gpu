FROM ubuntu:latest

MAINTAINER Martin Callaghan <m.callaghan@leeds.ac.uk> 

RUN apt-get -y update && apt-get install -y build-essential

RUN apt-get install -y apt-utils

RUN apt-get install -y gfortran

RUN apt-get install -y libopenblas-base

RUN apt-get install -y liblapacke-dev libnetcdf-dev libarpack2-dev libboost-all-dev

RUN apt-get install -y wget

RUN apt-get install -y libgtk2.0-dev

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh

ENV PATH /opt/conda/bin:$PATH

RUN pip install --upgrade pip

#Not sure this version will support GPUs- check

RUN pip install Theano

RUN conda install -y --quiet -c conda-forge tensorflow-gpu=1.1.0

RUN pip install keras

RUN pip install hyperas

RUN conda install jupyter -y --quiet && mkdir /opt/notebooks

RUN cd /opt/notebooks && wget http://archive.ics.uci.edu/ml/machine-learning-databases/ionosphere/ionosphere.data && \
    wget http://archive.ics.uci.edu/ml/machine-learning-databases/ionosphere/ionosphere.names

RUN cd /opt/notebooks && wget http://archive.ics.uci.edu/ml/machine-learning-databases/pima-indians-diabetes/pima-indians-diabetes.data && \
    wget http://archive.ics.uci.edu/ml/machine-learning-databases/pima-indians-diabetes/pima-indians-diabetes.names

RUN apt-get install -y nano

RUN  mkdir -p /nobackup

#Now install OpenCV

RUN conda install -y --quiet -c https://conda.binstar.org/menpo opencv3

RUN JN_PORT=$(shuf -i 8000-9000 -n 1)

RUN echo "Jupyter Notebook Server will run on port: ", $JN_PORT




