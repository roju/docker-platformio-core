FROM python:3.8-slim

ENV APP_VERSION="4.0.3" \
    APP="platformio-core"

LABEL app.name="${APP}" \
      app.version="${APP_VERSION}" \
      maintainer="Ross Justin"

COPY dummy-esp8266 /opt/dummy-esp8266

RUN mkdir -p /workspace && \
    apt-get update && \
    apt-get install -y --no-install-recommends curl unzip && \
    pip install -U platformio==${APP_VERSION} && \
    mkdir -p /.platformio && \
    chmod a+rwx /.platformio && \
    pio platform install espressif8266 --with-package framework-arduinoespressif8266

WORKDIR /opt/dummy-esp8266
RUN pio --version && pio run

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER 1001

WORKDIR /workspace

ENTRYPOINT ["platformio"] 