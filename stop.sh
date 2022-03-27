#!/bin/bash

KUBEEDGE_VERSION=v1.10.0
BIN_PATH=/etc/kubeedge/upgrade/${KUBEEDGE_VERSION}/bin/edgecore
DEFAULT_BIN_PATH=/usr/local/bin/edgecore
CONFIG_PATH=/etc/kubeedge/upgrade/${KUBEEDGE_VERSION}/config/edgecore.yaml
DEFAULT_CONFIG_PATH=/etc/kubeedge/config/edgecore.yaml

health=$(curl -s http://localhost:10350/healthz)
if [[ "$health" == "ok" ]]; then
	ln -srf ${BIN_PATH} ${DEFAULT_BIN_PATH}
	ln -srf ${CONFIG_PATH} ${DEFAULT_CONFIG_PATH}
fi

echo "Restart Edgecore..."
pkill edgecore && systemctl enable edgecore && systemctl daemon-reload && systemctl restart edgecore

