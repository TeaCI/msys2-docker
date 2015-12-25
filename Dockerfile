FROM ubuntu:14.04
MAINTAINER Qian Hong <qhong@codeweavers.com>
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:wine/wine-builds
RUN apt-get update && apt-get install -y --install-recommends wine-staging  winehq-staging wine-staging-i386 wget
# hack - wineboot without display, create wineprefix in a quick way, workaround wineboot event timeout
RUN DISPLAY=:88.0 wineboot
RUN cd ~/.wine/drive_c && wget http://repo.msys2.org/distrib/i686/msys2-base-i686-20150916.tar.xz && tar xf msys2-base-i686-20150916.tar.xz
