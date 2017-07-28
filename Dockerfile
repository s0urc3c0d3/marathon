from mesosphere/marathon
add entrypoint.sh /marathon/entrypoint.sh
add gen_hosts.sh /gen_hosts.sh
run cron ; crontab -r ; echo "*/5 * * * * /gen_hosts.sh > /etc/hosts" > /tmp/mycron ; crontab /tmp/mycron
expose 8080 8443
env HTTP_PORT=8080 HTTPS_PORT=8443 MARATHON_FEATURES=external_volumes
workdir /marathon
entrypoint /marathon/entrypoint.sh
