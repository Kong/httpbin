FROM amd64/ubuntu:focal@sha256:b2339eee806d44d6a8adc0a790f824fb71f03366dd754d400316ae5a7e3ece3e
RUN echo "disabled"

FROM arm64v8/ubuntu:focal@sha256:c01a10535d9ea3e4065dee4abdb288821b2918929f1e1584287a03e731b9176c
RUN echo "disabled"

FROM ubuntu:focal

LABEL name="httpbin"
LABEL version="0.9.2"
LABEL description="A simple HTTP service."
LABEL org.kennethreitz.vendor="Kenneth Reitz"

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN apt update -y && apt install python3-pip libssl-dev libffi-dev git -y && pip3 install --no-cache-dir pipenv

ADD Pipfile Pipfile.lock /httpbin/
WORKDIR /httpbin
RUN /bin/bash -c "pip3 install --no-cache-dir -r <(pipenv lock -r)"

ADD . /httpbin
RUN pip3 install --no-cache-dir /httpbin

EXPOSE 80

CMD ["gunicorn", "-b", "0.0.0.0:80", "httpbin:app", "-k", "gevent"]
