# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM armv7/armhf-baseimage:0.9.17

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y pptpd iptables

# Setup service
RUN mkdir -p /etc/service/pptpd
ADD pptpd.sh /etc/service/pptpd/run

ADD ipforward.conf /etc/sysctl.d/30-ipforward.conf

# Startup scripts to configure iptables/firewall
RUN mkdir -p /etc/my_init.d
ADD firewall-rules.sh /etc/my_init.d/firewall-rules.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

