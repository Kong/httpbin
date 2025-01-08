FROM ubuntu:jammy

LABEL name="httpbin"
LABEL description="A simple HTTP service."

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV HOME=/httpbin

WORKDIR /httpbin

ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    httpbin

RUN chown httpbin /httpbin
RUN chmod u+rwx /httpbin

RUN apt-get update -y && apt-get install python3-pip libssl-dev libffi-dev git libcap2-bin -y

ADD . .

RUN setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/python3.10
EXPOSE 80

USER httpbin
ENV PATH="/httpbin/.local/bin:$PATH"

RUN pip3 install --no-cache-dir pipenv
RUN pipenv sync

CMD ["pipenv", "run", "gunicorn", "-b", "0.0.0.0:80", "httpbin:app", "-k", "gevent"]
