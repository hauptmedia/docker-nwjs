FROM debian:jessie
MAINTAINER Julian Haupt <julian.haupt@hauptmedia.de>

ENV	DEBIAN_FRONTEND noninteractive
ENV	NWJS_VERSION v0.14.7
ENV	NWJS_INSTALL_DIR /opt/nwjs

RUN	apt-get update -qq && \
	apt-get install libexif12 libgconf-2-4 curl chromium xvfb x11vnc -y --no-install-recommends && \
	(curl -sL https://deb.nodesource.com/setup_5.x | bash -) && \
	apt-get install nodejs -y && \
	apt-get clean autoclean && \
	apt-get autoremove --yes && \
	rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN		mkdir -p ${NWJS_INSTALL_DIR} && \
		curl -L --silent http://dl.nwjs.io/${NWJS_VERSION}/nwjs-sdk-${NWJS_VERSION}-linux-x64.tar.gz | tar -xz --strip=1 -C ${NWJS_INSTALL_DIR} && \
		chown -R root:root ${NWJS_INSTALL_DIR}

ADD	xvfb-nw /usr/bin/xvfb-nw

EXPOSE 5900

CMD    ["/usr/bin/xvfb-nw"]
