FROM python:3.8-slim

ENV APP_VERSION="4.0.0" \
    APP="platformio-core"

LABEL app.name="${APP}" \
      app.version="${APP_VERSION}" \
      maintainer="Ross Justin"

RUN pip install -U platformio==${APP_VERSION} && \
    mkdir -p /workspace && \
    mkdir -p /.platformio && \
    chmod a+rwx /.platformio && \
    apt-get update && \
    apt-get install -y curl unzip

# ESP32 & ESP8266 Arduino Frameworks for Platformio

RUN pio platform install espressif8266 --with-package framework-arduinoespressif8266 \
 	&& pio platform install espressif32 \
 	&& cat /root/.platformio/platforms/espressif32/platform.py \
 	&& chmod 777 /root/.platformio/platforms/espressif32/platform.py \
 	&& sed -i 's/~2/>=1/g' /root/.platformio/platforms/espressif32/platform.py \
 	&& cat /root/.platformio/platforms/espressif32/platform.py

USER 1001

WORKDIR /workspace

ENTRYPOINT ["platformio"] 