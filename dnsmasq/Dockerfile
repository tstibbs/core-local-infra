FROM debian:bookworm
RUN apt-get update
RUN apt-get -y install dnsmasq
EXPOSE 53 53/udp
ENTRYPOINT ["dnsmasq", "-k"]
