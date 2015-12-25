FROM ubuntu:14.04
MAINTAINER Qian Hong <qhong@codeweavers.com>
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:wine/wine-builds
RUN apt-get update && apt-get install -y --install-recommends wine-staging  winehq-staging wine-staging-i386 wget xvfb 
# hack - wineboot without display, create wineprefix in a quick way, workaround wineboot event timeout
RUN DISPLAY=:88.0 wineboot
RUN cd ~/.wine/drive_c && wget http://repo.msys2.org/distrib/i686/msys2-base-i686-20150916.tar.xz && tar xf msys2-base-i686-20150916.tar.xz
COPY msys2-env /etc/
COPY msys2-shell /usr/bin/
RUN msys2-shell -c /etc/post-install/07-pacman-key.post
#RUN msys2-shell -c /usr/bin/pacman-key --init; msys2-shell -c /usr/bin/pacman-key --populate msys2; msys2-shell -c /usr/bin/pacman-key --refresh-keys;wineserver -k
RUN msys2-shell -c echo haha2
RUN ls ~/.wine/drive_c/msys32/etc/pacman.d
RUN ls ~/.wine/drive_c/msys32/etc/xml
RUN wine --version
RUN msys2-shell -c update-core
