FROM debian:jessie
MAINTAINER Julian Haupt <julian.haupt@hauptmedia.de>

ENV	DEBIAN_FRONTEND noninteractive
ENV	NWJS_VERSION v0.14.7
ENV	NWJS_INSTALL_DIR /opt/nwjs


RUN	apt-get update -qq && \
	apt-get install build-essential ca-certificates xterm fluxbox eterm supervisor libexif12 libgconf-2-4 curl chromium xvfb x11vnc -y --no-install-recommends && \
	apt-get --reinstall install xfonts-base -y && \
	apt-get clean autoclean && \
	apt-get autoremove --yes && \
	rm -rf /var/lib/{apt,dpkg,cache,log}/

#install nodejs
RUN     (curl -L https://deb.nodesource.com/setup_5.x | bash -) && \
        apt-get install -y nodejs && \
        ln -s /usr/bin/nodejs /usr/local/bin/node


#install nwjs
RUN		mkdir -p ${NWJS_INSTALL_DIR} && \
		curl -L --silent http://dl.nwjs.io/${NWJS_VERSION}/nwjs-sdk-${NWJS_VERSION}-linux-x64.tar.gz | tar -xz --strip=1 -C ${NWJS_INSTALL_DIR} && \
		chown -R root:root ${NWJS_INSTALL_DIR}


ENV     DISPLAY :99
ENV     XVFB_SCREENSIZE 1280x720x16
ENV     NWJS_ARGS ""

ADD     supervisor/conf.d/ /etc/supervisor/conf.d/

EXPOSE 5900

CMD    ["/usr/bin/supervisord"]
