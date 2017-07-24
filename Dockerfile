from mesosphere/marathon
add entrypoint.sh /marathon/entrypoint.sh
expose 8080 8443
env HTTP_PORT=8080 HTTPS_PORT=8443 MARATHON_FEATURES=external_volumes
workdir /marathon
entrypoint /entrypoint.sh
