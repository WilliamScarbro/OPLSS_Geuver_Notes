FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /workspace

COPY install.sh ./install.sh
RUN ./install.sh --install-deps

COPY . .

RUN ./install.sh

CMD ["./install.sh"]
