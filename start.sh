#!/bin/bash

KUBEEDGE_VERSION=v1.10.0
BIN_PATH=/etc/kubeedge/upgrade/${KUBEEDGE_VERSION}/bin/edgecore
CONFIG_PATH=/etc/kubeedge/upgrade/${KUBEEDGE_VERSION}/config/edgecore.yaml 
LOG_PATH=/etc/kubeedge/upgrade/log/edgecore.log

systemctl stop edgecore 
chmod +x ${BIN_PATH} && nohup ${BIN_PATH} --config ${CONFIG_PATH} > ${LOG_PATH} 2>&1 &
