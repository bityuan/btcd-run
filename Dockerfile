# Base image: https://hub.docker.com/_/golang/
FROM golang:1.9.2

RUN go get -u github.com/Masterminds/glide

RUN git clone https://github.com/btcsuite/btcd $GOPATH/src/github.com/btcsuite/btcd \
    && cd $GOPATH/src/github.com/btcsuite/btcd \
    && glide install \
    && go install . ./cmd/.

RUN git clone https://github.com/btcsuite/btcwallet $GOPATH/src/github.com/btcsuite/btcwallet \
    && cd $GOPATH/src/github.com/btcsuite/btcwallet \
    && glide install \
    && go install

RUN apt autoremove \
    && apt clean && go clean

WORKDIR /root

COPY daemon.sh daemon.sh
RUN chmod +x daemon.sh

CMD [ "/bin/bash", "-c", "/root/daemon.sh"]



