# Use the specified version of NGINX on Alpine as the base image
FROM nginx:1.25.3-alpine

# Set environment variables for NGINX version and Echo module version
ENV NGINX_VERSION 1.25.3
ENV ECHO_MODULE_VERSION 0.62

# Install build dependencies
RUN apk add --no-cache --virtual .build-deps \
        gcc \
        libc-dev \
        make \
        openssl-dev \
        pcre-dev \
        zlib-dev \
        linux-headers \
        curl \
        gnupg \
        libxslt-dev \
        gd-dev \
        geoip-dev \
        perl-dev \
        libedit-dev \
        bash \
        alpine-sdk \
        findutils

# Download NGINX and ngx_http_echo_module sources
RUN wget "http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz" -O nginx.tar.gz \
    && wget "https://github.com/openresty/echo-nginx-module/archive/v$ECHO_MODULE_VERSION.tar.gz" -O echo_module.tar.gz

# Extract the downloaded sources
RUN mkdir -p /usr/src \
    && tar -zxC /usr/src -f nginx.tar.gz \
    && tar -zxC /usr/src -f echo_module.tar.gz \
    && rm nginx.tar.gz echo_module.tar.gz

# Compile ngx_http_echo_module as a dynamic module
RUN cd /usr/src/nginx-$NGINX_VERSION \
    && ./configure --with-compat --add-dynamic-module=/usr/src/echo-nginx-module-$ECHO_MODULE_VERSION \
    && make modules

# Copy the compiled module to the standard modules directory
RUN cp /usr/src/nginx-$NGINX_VERSION/objs/ngx_http_echo_module.so /usr/lib/nginx/modules/

# Cleanup
RUN apk del .build-deps \
    && rm -rf /usr/src/nginx-$NGINX_VERSION /usr/src/echo-nginx-module-$ECHO_MODULE_VERSION

# Load the module in the NGINX configuration
RUN echo "load_module modules/ngx_http_echo_module.so;" > /etc/nginx/modules/ngx_http_echo_module.conf

# Expose port 80
EXPOSE 80

# Command to run NGINX
CMD ["nginx", "-g", "daemon off;"]
