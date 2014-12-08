FROM sequenceiq/spark:1.1.0
MAINTAINER thisgokeboysef

#RUN yum -y install numpy scipy python-matplotlib gcc gcc-c++

# Following needed to build numpy, scikit-learn
RUN yum -y install gcc gcc-c++ lapack lapack-devel blas blas-devel python-devel
RUN yum clean all

RUN curl https://bootstrap.pypa.io/get-pip.py > get-pip.py
RUN python get-pip.py 
RUN pip install -U numpy scipy scikit-learn
#RUN easy_install -U cython scikit-image

#ENV PATH $PATH:/opt/anaconda/bin
#RUN yum update -y && yum install -y wget bzip2 screen
#RUN echo 'export PATH=/opt/anaconda/bin:$PATH' > /etc/profile.d/conda.sh
#RUN ( echo "=======================" ) && \
 #   ( echo "Installing Python      " ) && \
  #  ( echo "=======================" ) && \
   # wget --quiet http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh && \
    #/bin/bash /Miniconda-latest-Linux-x86_64.sh -b -p /opt/anaconda && \
    #rm Miniconda-latest-Linux-x86_64.sh && \
    #test -f /opt/anaconda/bin/conda && \
    #conda install --yes pip
    #conda install --yes numpy
    #conda install --yes scipy
    #conda install --yes matplotlib
    #conda install --yes ipython
    #conda install --yes scikit-learn
    #conda install --yes scikit-imag	
    #conda install --yes pandas
    #conda install --yes requests
    #conda install --yes h5py

# Reduce number of warning messages
ADD log4j.properties /usr/local/spark/conf/log4j.properties

# Needed for Spark to run in Yarn mode
ENV MASTER yarn
CMD ["/etc/bootstrap.sh", "-d"]
