FROM progrium/busybox
MAINTAINER thisgokeboysef

RUN opkg-install bash bzip2
ADD conda_install.sh /usr/local/conda_install.sh
RUN ["bash", "/root/conda_install.sh"]
ENV PATH /usr/local/miniconda3/bin:$PATH
