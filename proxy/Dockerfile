FROM httpd:2.4

WORKDIR /usr/local/apache2/
RUN echo "Include conf/default-virtual-host.conf*" >> conf/httpd.conf
RUN echo "Include conf.d/*" >> conf/httpd.conf
