FROM ubuntu
LABEL maintainer="javireyes"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false

RUN set -xe \
    && apt update \
    && apt -y install python3-pip
RUN apt -y install curl 

RUN curl -sL https://deb.nodesource.com/setup_14.x |bash -
RUN apt install -y nodejs
RUN npm install -g yarn


RUN pip install --upgrade pip && \
    pip install -r /tmp/requirements.txt &&\
    if [ $DEV = "true" ]; \
    then pip install -r /tmp/requirements.dev.txt ; \
    fi && \
    rm -rf /tmp && \
    adduser \
    --disabled-password \
    --no-create-home \
    django-user


USER django-user