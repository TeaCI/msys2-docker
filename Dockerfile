FROM ubuntu:14.04
MAINTAINER Qian Hong <qhong@codeweavers.com>
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:wine/wine-builds
RUN apt-get update && apt-get install -y --install-recommends wine-staging  winehq-staging
