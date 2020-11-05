FROM golang:latest
RUN go get github.com/rnurgaliyev/co2meter_exporter
RUN CGO_ENABLED=0 GOOS=linux GOARCH=arm GOARM=7 \
    go build -o /co2meter_exporter \
    -v github.com/rnurgaliyev/co2meter_exporter

FROM arm32v7/alpine:latest
COPY --from=0 /co2meter_exporter /bin
EXPOSE 2112
CMD ["/bin/co2meter_exporter", "-d", "/dev/hidraw0", "-p", "2112"]
