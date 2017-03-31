#!/bin/bash
DO_REGION=${DO_REGION:="sfo1"}
DO_SIZE=${DO_SIZE:="512mb"}
DO_NODE_BASENAME=${DO_NODE_BASENAME:="minion"}

hash docker-machine 2>/dev/null || { echo >&2 "Cannot find 'docker-machine', install with 'brew install docker-machine' or visit https://docs.docker.com/machine/install-machine/"; exit 1; }
[ -n ${DIGITALOCEAN_ACCESS_TOKEN} ] || { echo "Must define env var DIGITALOCEAN_ACCESS_TOKEN with DO app key, see  https://cloud.digitalocean.com/settings/api/tokens" && exit 1; }

if [ -n "${DIGITALOCEAN_SSH_KEY_PATH}" ]; then
    DIGITALOCEAN_SSH_KEY_FINGERPRINT=$(ssh-keygen -l -E md5 -f ${DIGITALOCEAN_SSH_KEY_PATH} | cut -d ' ' -f 2 | cut -d : -f 2-17)
    echo "Found ssh private cert file: ${DIGITALOCEAN_SSH_KEY_PATH}"
    echo "with fingerprint: ${DIGITALOCEAN_SSH_KEY_FINGERPRINT}"
    _ssh_details="--digitalocean-ssh-key-path ${DIGITALOCEAN_SSH_KEY_PATH} --digitalocean-ssh-key-fingerprint ${DIGITALOCEAN_SSH_KEY_FINGERPRINT}"
    # _ssh_details=" --digitalocean-ssh-key-fingerprint ${DIGITALOCEAN_SSH_KEY_FINGERPRINT}"
else
    echo "Letting docker-machine generate SSH credentials."
    _ssh_details=
fi

docker-machine create --driver digitalocean \
    --digitalocean-image coreos-stable \
    --digitalocean-region ${DO_REGION} \
    --digitalocean-size ${DO_SIZE} \
    --digitalocean-ipv6 \
    --digitalocean-private-networking \
    --digitalocean-ssh-user core \
    ${_ssh_details} \
    $DO_NODE_BASENAME
