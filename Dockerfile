FROM ubuntu:14.04
MAINTAINER Qian Hong <qhong@codeweavers.com>
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:wine/wine-builds
RUN apt-get update && apt-get install -y --install-recommends wine-staging  winehq-staging wine-staging-i386 wget xvfb 
# hack - wineboot without display, create wineprefix in a quick way, workaround wineboot event timeout
RUN DISPLAY=:78.0 wineboot
RUN cd ~/.wine/drive_c && wget http://repo.msys2.org/distrib/i686/msys2-base-i686-20150916.tar.xz && tar xf msys2-base-i686-20150916.tar.xz
RUN sed -i 's/clear/echo clear/' ~/.wine/drive_c/msys32/etc/profile
RUN sed -i 's/env bash/bash/' ~/.wine/drive_c/msys32/usr/bin/pacman-key
RUN sed -i 's/true/echo $PATH/' ~/.wine/drive_c/msys32/etc/post-install/07-pacman-key.post
COPY msys2-env /etc/
COPY msys2-shell /usr/bin/
RUN ls ~/.wine/drive_c/msys32/usr/bin/msys-curl-4.dll
RUN ls ~/.wine/drive_c/msys32/usr/bin/msys-gcc_s-1.dll
RUN export DISPLAY=:77; (Xvfb :77 -ac -screen 0 800x600x16 &);wineconsole ~/.wine/drive_c/msys32/usr/bin/script.exe typescript.999 -q -f -e -c '/usr/bin/bash.exe -l -x -c "ls"'; wineserver -k;  cat typescript.999
#RUN msys2-shell -c /etc/post-install/07-pacman-key.post
RUN msys2-shell -c /usr/bin/pacman-key --init 
#RUN msys2-shell -c echo haha2
RUN ls ~/.wine/drive_c/msys32/etc/pacman.d
RUN ls ~/.wine/drive_c/msys32/etc/xml
RUN wine --version
#RUN msys2-shell -c update-core
