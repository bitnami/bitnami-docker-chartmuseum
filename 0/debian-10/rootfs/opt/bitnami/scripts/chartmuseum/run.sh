#!/bin/bash
#
# Bitnami Chartmuseum run

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
#set -o xtrace # Uncomment this line for debugging purpose

# Load libraries
. /opt/bitnami/scripts/libfs.sh
. /opt/bitnami/scripts/liblog.sh

FLAGS=''
STORAGE="${STORAGE:-local}"

if ! is_dir_empty "/bitnami/certs"; then
    FLAGS='--tls-cert /bitnami/certs/server.crt --tls-key /bitnami/certs/server.key'
fi

if [[ "$STORAGE" = "local" ]]; then
    info "Using local storage into /bitnami/data directory"
    STORAGE_LOCAL_ROOTDIR='/bitnami/data'
    FLAGS="$FLAGS --storage $STORAGE --storage-local-rootdir $STORAGE_LOCAL_ROOTDIR"
fi

info "** Starting chartmuseum **"
exec /opt/bitnami/chartmuseum/bin/chartmuseum $FLAGS
