# build stage
FROM golang:alpine as emissary
WORKDIR /go/src/github.com/jshaw86/gocql_ccm_minikube
RUN apk --no-cache add git=2.13.5-r0 make=4.2.1-r0 glide=0.12.3-r1
COPY . /go/src/github.com/jshaw86/gocql_ccm_minikube
RUN glide install
RUN make linux

# Setup the environment
FROM alpine:edge
WORKDIR /app
RUN apk --no-cache add tini
COPY --from=emissary /go/src/github.com/jshaw86/gocql_ccm_minikube/emissary-linux-amd64 /app
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/app/emissary-linux-amd64"]
