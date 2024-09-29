#!/usr/bin/dumb-init /bin/sh

set -e
ulimit -c 0

auto_unseal() {
    export VAULT_ADDR=http://127.0.0.1:8200

    iter=0

    while usleep 250000; do
        let iter=iter+1
        echo -n "Auto unseal [$iter]: "
        set +e
        bao status >/dev/null
        rc=$?
        set -e
        if [ $rc -eq 0 ]; then
            echo unsealed.
            return 0
        elif [ $rc -eq 1 ]; then
            echo error, retrying
        elif [ $rc -eq 2 ]; then
            echo unsealing
            set +e
            bao operator unseal "$(cat /run/secrets/vault_token)"
            set -e
            sleep 2
        else 
            echo Unknown error $rc, aborting
            return $rc
        fi 
    done    
}

get_addr () {
    local if_name=$1
    local uri_template=$2
    ip addr show dev $if_name | awk -v uri=$uri_template '/\s*inet\s/ { \
      ip=gensub(/(.+)\/.+/, "\\1", "g", $2); \
      print gensub(/^(.+:\/\/).+(:.+)$/, "\\1" ip "\\2", "g", uri); \
      exit}'
}

if [ -n "$BAO_CLUSTER_INTERFACE" ]; then
    export BAO_CLUSTER_ADDR=$(get_addr $BAO_CLUSTER_INTERFACE ${BAO_CLUSTER_ADDR:-"https://0.0.0.0:8201"})
    echo "Using $BAO_CLUSTER_INTERFACE for BAO_CLUSTER_ADDR: $BAO_CLUSTER_ADDR"
fi

if [ "$1" = 'bao' ]; then

    if [ -z "$SKIP_UNSEAL" -a -f "/run/secrets/vault_token" ]; then
        auto_unseal >> /var/log/auto_unseal 2>&1 &
    fi

    if [ -z "$SKIP_CHOWN" ]; then
        if [ "$(stat -c %u /data)" != "$(id -u openbao)" ]; then
            chown -R openbao:openbao /data || echo "Could not chown /data (may not have appropriate permissions)"
        fi
    fi

    if [ "$(id -u)" = '0' ]; then
      set -- su-exec openbao "$@"
    fi

fi

exec "$@"
