# syntax=docker/dockerfile:1

FROM python:3.12.3-slim

RUN apt-get update && apt-get install -y -q --no-install-recommends libmagic1 \
    apache2-utils git nginx build-essential curl jq wget procps libgl1 libglib2.0-0 libxrender1 libsm6 libxext6 libx11-6

RUN pip install wheel setuptools pip gunicorn --upgrade

RUN mkdir /srv/spectra

COPY etc_doc/nginx/sites-available/default /etc/nginx/sites-available/default
RUN chmod 644 /etc/nginx/sites-available/default

EXPOSE 4001

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PIDFILE=/srv/spectra/pid
RUN echo "123123231" > /srv/spectra/pid
WORKDIR /srv/spectra

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

COPY ./etc_doc/docker.py /usr/local/bin/docker
RUN chmod +x /usr/local/bin/docker

COPY ./etc_doc/*.sh ./
RUN chmod +x ./*.sh

CMD bash ./entrypoint.sh