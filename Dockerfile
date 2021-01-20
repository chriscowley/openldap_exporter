FROM quay.io/bitnami/golang:1.15 AS build
#RUN apk --no-cache add make
WORKDIR /src/
COPY . /src/
RUN make build

FROM alpine
RUN apk --no-cache add libc6-compat
COPY --from=build /src/target/openldap_exporter-linux /openldap_exporter
EXPOSE 9330
ENTRYPOINT ["/openldap_exporter"]
