FROM docker.io/alemok/myappsocials:latest

RUN sed -i 's/listen[: ]*80;/listen 7860;/g' /etc/nginx/conf.d/default.conf

RUN mkdir -p /var/cache/nginx/client_body /var/cache/nginx/proxy /var/cache/nginx/fastcgi /var/cache/nginx/uwsgi /var/cache/nginx/scgi && chmod -R 777 /var/cache/nginx /var/run /var/log/nginx /etc/nginx/conf.d

EXPOSE 7860

CMD ["nginx", "-g", "daemon off;"]
