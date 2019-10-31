FROM python:3.8-slim

LABEL app.name="platformio-core" \
      maintainer="Ross Justin"

COPY dummy-esp8266 /opt/dummy-esp8266

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl unzip && \
    pip install -U platformio && \
    mkdir -p /workspace && \
    mkdir -p /.platformio && \
    chmod a+rwx /.platformio && \
    pio platform install espressif8266 --with-package framework-arduinoespressif8266 && \
    export PATH=$PATH:/root/esp/xtensa-esp32-elf/bin && \
    echo "export PATH=$PATH:/root/esp/xtensa-esp32-elf/bin" > ~/.profile && \
    pio --version && pio run -d /opt/dummy-esp8266 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER 1001

WORKDIR /workspace

ENTRYPOINT ["platformio"] 