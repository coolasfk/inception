FROM nginx:alpine

RUN apk update && apk add openssl

COPY conf /etc/nginx/conf.d

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]