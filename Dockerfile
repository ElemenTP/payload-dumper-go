FROM golang as builder

RUN git clone https://github.com/ElemenTP/payload-dumper-go

RUN cd payload-dumper-go \
    && CGO_ENABLED=0 GOOS=linux go build -a -trimpath -ldflags '-w -s -buildid=' /go/payload-dumper-go

FROM alpine
COPY --from=builder /go/payload-dumper-go/payload-dumper-go /go/bin/
ENTRYPOINT ["/go/bin/payload-dumper-go"]
