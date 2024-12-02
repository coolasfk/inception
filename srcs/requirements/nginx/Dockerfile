# Base image
FROM debian:buster

# Install necessary tools
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && apt-get clean \
    curl

# Create directories for certificates
RUN mkdir -p /etc/nginx/ssl /etc/nginx/ca

# Generate a root CA certificate
RUN openssl genrsa -out /etc/nginx/ca/ca.key 2048 && \
    openssl req -x509 -new -nodes -key /etc/nginx/ca/ca.key \
        -sha256 -days 3650 -out /etc/nginx/ca/ca.crt \
        -subj "/C=US/ST=State/L=City/O=Organization/OU=Unit/CN=MyCustomCA"

# Generate server private key
RUN openssl genrsa -out /etc/nginx/ssl/nginx.key 2048

# Generate a certificate signing request (CSR) for the server
RUN openssl req -new -key /etc/nginx/ssl/nginx.key \
        -out /etc/nginx/ssl/nginx.csr \
        -subj "/C=CH/ST=Vaud/L=City/O=Organization/OU=Unit/CN=eprzybyl"

# Sign the server certificate with the root CA
RUN openssl x509 -req -in /etc/nginx/ssl/nginx.csr \
        -CA /etc/nginx/ca/ca.crt -CAkey /etc/nginx/ca/ca.key -CAcreateserial \
        -out /etc/nginx/ssl/nginx.crt -days 365 -sha256

        RUN cat /etc/nginx/ssl/nginx.crt /etc/nginx/ca/ca.crt > /etc/nginx/ssl/nginx.fullchain.crt
# Copy custom Nginx configuration
COPY conf/default.conf /etc/nginx/conf.d/default.conf

# Expose port 443 for HTTPS traffic
EXPOSE 443
COPY conf/nginx.crt /usr/local/share/ca-certificates/nginx.crt
RUN update-ca-certificates
# Start Nginx with daemon mode off to keep the container running
CMD ["nginx", "-g", "daemon off;"]
