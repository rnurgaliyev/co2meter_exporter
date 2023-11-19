FROM golang:latest AS builder
RUN GOBIN=/ go install github.com/rnurgaliyev/co2meter_exporter@latest

FROM arm32v7/alpine:latest
COPY --from=builder /co2meter_exporter /bin
EXPOSE 2112
CMD ["/bin/co2meter_exporter", "-d", "/dev/hidraw0", "-p", "2112"]
