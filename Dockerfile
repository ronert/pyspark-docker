FROM sequenceiq/hadoop-docker:2.6.0
MAINTAINER Ronert Obst <ronert.obst@gmail.com>

### Spark setup
RUN curl -s http://d3kbcqa49mib13.cloudfront.net/spark-1.3.0-bin-hadoop2.4.tgz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s spark-1.3.0-bin-hadoop2.4 spark
ENV SPARK_HOME /usr/local/spark
RUN mkdir $SPARK_HOME/yarn-remote-client
ADD yarn-remote-client $SPARK_HOME/yarn-remote-client

RUN $BOOTSTRAP && $HADOOP_PREFIX/bin/hadoop dfsadmin -safemode leave && $HADOOP_PREFIX/bin/hdfs dfs -put $SPARK_HOME-1.3.0-bin-hadoop2.4/lib /spark

ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop
ENV SPARK_JAR hdfs:///spark/spark-assembly-1.3.0-hadoop2.4.0.jar
#ENV HADOOP_USER_NAME hdfs
ENV PATH $PATH:$SPARK_HOME/bin:$HADOOP_PREFIX/bin

### Python and utilities setup
ENV PATH /opt/anaconda/bin:$PATH
RUN yum --enablerepo=base clean metadata && yum update -y && yum install -y wget bzip2
RUN echo 'export PATH=/opt/anaconda/bin:$PATH' > /etc/profile.d/conda.sh
RUN ( echo "=======================" ) && \
    ( echo "Installing Python      " ) && \
    ( echo "=======================" ) && \
    wget --quiet http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh && \
    /bin/bash /Miniconda-latest-Linux-x86_64.sh -b -p /opt/anaconda && \
    rm Miniconda-latest-Linux-x86_64.sh && \
    test -f /opt/anaconda/bin/conda && \
    conda install --yes pip && \
    conda install --yes numpy && \
    conda install --yes scipy && \
    conda install --yes matplotlib && \
    conda install --yes ipython && \
    conda install --yes scikit-learn && \
    conda install --yes toolz && \
    conda install --yes pandas
RUN echo "SPARK_YARN_USER_ENV=/opt/anaconda/bin/python" > /usr/local/spark/conf/spark-env.sh && \
    echo "PYSPARK_PYTHON=/opt/anaconda/bin/python" >> /usr/local/spark/conf/spark-env.sh

CMD ["/etc/bootstrap.sh", "-d"]
