FROM alpine:latest

LABEL maintainer="Ceffji"

RUN apk add --update openvpn iptables
	
ADD ./scripts /usr/local/bin
RUN chmod a+x /usr/local/bin/*

ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]
