FROM sequenceiq/spark:1.1.0
MAINTAINER thisgokeboysef

ADD src/ /tmp
RUN /tmp/install.sh

ENV PATH /root/anaconda/bin:$PATH 

CMD ["/sbin/my_init" , "--","bash", "-l"]
