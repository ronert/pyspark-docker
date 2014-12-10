FROM mlovci/base
MAINTAINER thisgokeboysef


ADD http://repo.continuum.io/miniconda/Miniconda-3.7.0-Linux-x86_64.sh /home/root/software/

WORKDIR /home/root/software

RUN ["chmod", "u+x", "Miniconda-3.7.0-Linux-x86_64.sh"]
RUN ./Miniconda-3.7.0-Linux-x86_64.sh -b -p /usr/local/miniconda -f
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/miniconda/bin  
RUN conda install --yes cython numpy scipy scikit-learn pip pandas ipython jinja2 tornado pyzmq matplotlib pyqt
RUN pip install patsy && pip install seaborn brewer2mpl networkx semantic_version statsmodels htseq misopy pybedtools gffutils cutadapt pysam
