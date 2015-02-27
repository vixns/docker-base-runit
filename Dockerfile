#
# Base Image
#

FROM vixns/base
MAINTAINER Stéphane Cottin <stephane.cottin@vixns.com>
ENV DEBIAN_FRONTEND noninteractive

RUN \
  apt-get update -q && \
  apt-get install -t wheezy-backports -y runit ssmtp && \
  apt-get -y dist-upgrade --no-install-recommends && \
  apt-get -y autoremove && \
  apt-get -y autoclean && \
  apt-get -y clean && \
  rm -rf /var/lib/apt/lists/*

COPY ./ssmtp.conf /etc/ssmtp/ssmtp.conf
COPY ./runsvdir-start /usr/local/sbin/runsvdir-start
RUN chmod +x /usr/local/sbin/runsvdir-start

ENTRYPOINT ["/usr/local/sbin/runsvdir-start"]