# Base image
FROM nginx:alpine

# Install necessary tools
RUN apk update && apk add openssl

# Copy custom Nginx configuration
COPY conf/default.conf /etc/nginx/conf.d/default.conf

# Expose port 443 for HTTPS traffic
EXPOSE 443
COPY conf/nginx.crt /usr/local/share/ca-certificates/nginx.crt
RUN update-ca-certificates
# Start Nginx with daemon mode off to keep the container running
CMD ["nginx", "-g", "daemon off;"]
