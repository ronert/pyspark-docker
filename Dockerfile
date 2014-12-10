FROM phusion/baseimage:latest
MAINTAINER thisgokeboysef


ADD src/ /tmp
RUN /tmp/install.sh

ENV PATH /root/anaconda/bin:$PATH 

CMD ["/sbin/my_init" , "--","bash", "-l"]
