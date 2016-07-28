FROM debian:jessie
MAINTAINER Julian Haupt <julian.haupt@hauptmedia.de>

ENV	DEBIAN_FRONTEND noninteractive
ENV	NWJS_VERSION v0.14.7
ENV	NWJS_INSTALL_DIR /opt/nwjs

RUN	apt-get update -qq && \
	apt-get install curl chromium xvfb -y --no-install-recommends && \
	apt-get clean autoclean && \
	apt-get autoremove --yes && \
	rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN		mkdir -p ${NWJS_INSTALL_DIR} && \
		curl -L --silent http://dl.nwjs.io/${NWJS_VERSION}/nwjs-sdk-${NWJS_VERSION}-linux-x64.tar.gz | tar -xz --strip=1 -C ${NWJS_INSTALL_DIR}

