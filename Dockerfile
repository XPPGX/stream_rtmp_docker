FROM ubuntu:latest

RUN apt-get update \ 
    && apt-get install -y wget \
    && apt-get install -y nano \
    && apt-get install -y git \
    && cd /home \
    && git clone https://github.com/sergey-dryabzhinsky/nginx-rtmp-module.git \
    && apt-get install -y build-essential libpcre3 libpcre3-dev libssl-dev \
    && wget http://nginx.org/download/nginx-1.18.0.tar.gz \
    && tar -xf nginx-1.18.0.tar.gz \
    && cd nginx-1.18.0 \
    && apt-get install -y zlib1g-dev \
    && ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module \
    && make -j 4 \
    && make install

#COPY nginx.conf /usr/local/nginx/conf/nginx.conf

RUN cd /usr/local/nginx/conf && mkdir hls


CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
