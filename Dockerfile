FROM python:3.8-slim

ENV APP_VERSION="4.0.3" \
    APP="platformio-core"

LABEL app.name="${APP}" \
      app.version="${APP_VERSION}" \
      maintainer="Ross Justin"

RUN pip install -U platformio==${APP_VERSION} && \
    mkdir -p /workspace && \
    mkdir -p /.platformio && \
    chmod a+rwx /.platformio && \
    platformio platform install espressif32 && \
    apt-get update && \
    apt-get install -y curl unzip && \
    rm -rf /var/lib/apt/lists/*


USER 1001

WORKDIR /workspace

ENTRYPOINT ["platformio"] 