FROM amd64/ubuntu:bionic@sha256:8da4e9509bfe5e09df6502e7a8e93c63e4d0d9dbaa9f92d7d767f96d6c20a78a
RUN echo "disabled"

FROM arm64v8/ubuntu:bionic@sha256:6a4619c02fbaf80504f316f42bd4b732831d9590e9c1c0df2b6f294ffbee86c9
RUN echo "disabled"

FROM ubuntu:bionic

LABEL name="httpbin"
LABEL version="0.9.2"
LABEL description="A simple HTTP service."
LABEL org.kennethreitz.vendor="Kenneth Reitz"

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN apt update -y && apt install python3-pip git -y && pip3 install --no-cache-dir pipenv

ADD Pipfile Pipfile.lock /httpbin/
WORKDIR /httpbin
RUN /bin/bash -c "pip3 install --no-cache-dir -r <(pipenv lock -r)"

ADD . /httpbin
RUN pip3 install --no-cache-dir /httpbin

EXPOSE 80

CMD ["gunicorn", "-b", "0.0.0.0:80", "httpbin:app", "-k", "gevent"]
