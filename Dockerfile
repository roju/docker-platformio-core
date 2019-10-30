FROM python:3.7-slim

ENV APP_VERSION="4.0.0" \
    APP="platformio-core"

LABEL app.name="${APP}" \
      app.version="${APP_VERSION}" \
      maintainer="Ross Justin"

RUN pip install -U pip setuptools
	pip install -U platformio==${APP_VERSION} && \
    mkdir -p /workspace && \
    mkdir -p /.platformio && \
    chmod a+rwx /.platformio && \
    pip install -U httpie

USER 1001

WORKDIR /workspace

ENTRYPOINT ["platformio"] 