FROM docker.io/golang:1.15 AS build
#RUN apk --no-cache add make
WORKDIR /src/
COPY . /src/
RUN make build

FROM scratch
COPY --from=build /src/target/openldap_exporter-linux /openldap_exporter
EXPOSE 9330
ENTRYPOINT ["/openldap_exporter"]
