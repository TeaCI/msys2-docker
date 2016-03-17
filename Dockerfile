FROM ubuntu:14.04
MAINTAINER Qian Hong <qhong@codeweavers.com>
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:wine/wine-builds
RUN apt-get update && apt-get install -y --install-recommends wine-staging winehq-staging winetricks wget xvfb
RUN apt-get install -y language-pack-en-base language-pack-en
RUN apt-get clean -y
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV TERM xterm
# Work around https://bugs.wine-staging.com/show_bug.cgi?id=626
ENV WINPTY_SHOW_CONSOLE 1
COPY msys32-env /etc/
COPY msys64-env /etc/
COPY msys2-shell /usr/bin/
COPY msys32-init /usr/bin/
COPY msys32 /usr/bin/
COPY msys64 /usr/bin/
COPY mingw32 /usr/bin/
COPY mingw64 /usr/bin/
RUN msys32-init
RUN msys32 -c pacman -Su --needed --noconfirm --noprogressbar
RUN msys32 -c pacman -S --needed --noconfirm --noprogressbar base-devel
RUN msys32 -c pacman -S --needed --noconfirm --noprogressbar msys2-devel
RUN msys32 -c pacman -S --needed --noconfirm --noprogressbar mingw-w64-i686-toolchain
RUN msys32 -c pacman -S --needed --noconfirm --noprogressbar git subversion
RUN msys32 -c rm -rf /var/cache/pacman/pkg/*
RUN msys32 -c cp -f /usr/bin/false /usr/bin/tput
#RUN WINEDEBUG=-all DISPLAY=:55.0 wine wineconsole --backend=curses autorebase.bat; wineserver -w
