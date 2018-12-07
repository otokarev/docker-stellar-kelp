FROM golang:alpine as builder

ENV VERSION=v1.2.0


RUN apk add --no-cache git glide bash \
    && mkdir -p /go/src/github.com/lightyeario/ \
    && git clone https://github.com/interstellar/kelp.git /go/src/github.com/lightyeario/kelp \
    && cd /go/src/github.com/lightyeario/kelp  \
    && git checkout $VERSION \
    && glide install \
    && bash ./scripts/build.sh

FROM alpine:latest

COPY --from=builder /go/src/github.com/lightyeario/kelp/bin/kelp /usr/local/bin/kelp

ENTRYPOINT ["/usr/local/bin/kelp"]