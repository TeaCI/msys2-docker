FROM ubuntu:14.04
MAINTAINER Qian Hong <qhong@codeweavers.com>
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:wine/wine-builds
RUN apt-get update && apt-get install -y --install-recommends wine-staging winehq-staging wget xvfb 
RUN apt-get install -y language-pack-en-base language-pack-en
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
COPY msys2-env /etc/
COPY msys2-shell /usr/bin/
COPY msys2-init /usr/bin/
COPY msys2-drone-entry /usr/bin/
RUN msys2-init
