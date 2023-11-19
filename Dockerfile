FROM golang:latest AS builder
RUN GOBIN=/ CGO_ENABLED=0 GOOS=linux GOARCH=arm GOARM=7 \
    go install github.com/rnurgaliyev/co2meter_exporter@latest

FROM arm32v7/alpine:latest
COPY --from=builder /co2meter_exporter /bin/co2meter_exporter
RUN chmod +x /bin/co2meter_exporter
EXPOSE 2112
CMD ["/bin/co2meter_exporter", "-d", "/dev/hidraw0", "-p", "2112"]
