FROM python:3.11-slim
RUN apt-get update && apt-get install nginx -y
COPY docker/nginx/default.conf /etc/nginx/conf.d/default.conf
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log
COPY service/src /app
COPY docker/entrypoint.sh /
COPY ui/static /www/data
WORKDIR /app
RUN python -m venv /opt/venv && \
    /opt/venv/bin/python -m pip install pip --upgrade && \
    /opt/venv/bin/python -m pip install -r requirements.txt
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]
