FROM ubuntu:latest

LABEL name="httpbin"
LABEL description="A simple HTTP service."

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN apt update -y && apt install python3-pip libssl-dev libffi-dev git -y && pip3 install --no-cache-dir pipenv

WORKDIR /httpbin
ADD . .
RUN pipenv sync

EXPOSE 80

CMD ["pipenv", "run", "gunicorn", "-b", "0.0.0.0:80", "httpbin:app", "-k", "gevent"]
