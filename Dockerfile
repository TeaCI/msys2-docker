FROM ubuntu:14.04
MAINTAINER Qian Hong <qhong@codeweavers.com>
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install -y software-properties-common
RUN echo nameserver 114.114.114.114 > /etc/resolv.conf; add-apt-repository -y ppa:wine/wine-builds
RUN echo nameserver 114.114.114.114 > /etc/resolv.conf; ping -c 4 archive.ubuntu.com
RUN echo nameserver 114.114.114.114 > /etc/resolv.conf; echo 91.189.91.15 archive.ubuntu.com >> /etc/hosts; apt-get update && apt-get install -y --install-recommends wine-staging  winehq-staging wine-staging-i386 wget xvfb 
# hack - wineboot without display, create wineprefix in a quick way, workaround wineboot event timeout
#RUN DISPLAY=:78.0 wineboot; wineserver -w
# mark don't change above
#RUN echo nameserver 114.114.114.114 > /etc/resolv.conf; echo 45.59.69.178 repo.msys2.org >> /etc/hosts; cd ~/.wine/drive_c && wget http://repo.msys2.org/distrib/i686/msys2-base-i686-20150916.tar.xz && tar xf msys2-base-i686-20150916.tar.xz
COPY msys2-env /etc/
COPY msys2-shell /usr/bin/
COPY msys2-init /usr/bin/
RUN msys2-init
