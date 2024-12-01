# Base image
FROM nginx:alpine

# Install necessary tools
RUN apk update && apk add openssl

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
        -subj "/C=US/ST=State/L=City/O=Organization/OU=Unit/CN=eprzybyl.42.fr"

# Sign the server certificate with the root CA
RUN openssl x509 -req -in /etc/nginx/ssl/nginx.csr \
        -CA /etc/nginx/ca/ca.crt -CAkey /etc/nginx/ca/ca.key -CAcreateserial \
        -out /etc/nginx/ssl/nginx.crt -days 365 -sha256

# Copy custom Nginx configuration
COPY conf/default.conf /etc/nginx/conf.d/default.conf

# Expose port 443 for HTTPS traffic and 80 for HTTP
EXPOSE 443


# Start Nginx with daemon mode off to keep the container running
CMD ["nginx", "-g", "daemon off;"]
