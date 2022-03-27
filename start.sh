#!/bin/bash

KUBEEDGE_VERSION=v1.10.0
LOG_PATH=/etc/kubeedge/upgrade/log/edgecore.log

BIN_PATH=/etc/kubeedge/upgrade/${KUBEEDGE_VERSION}/bin/edgecore
DEFAULT_BIN_PATH=/usr/local/bin/edgecore
CONFIG_PATH=/etc/kubeedge/upgrade/${KUBEEDGE_VERSION}/config/edgecore.yaml
DEFAULT_CONFIG_PATH=/etc/kubeedge/config/edgecore.yaml

systemctl stop edgecore 

echo "Start the fresh Edgecore..."
chmod +x ${BIN_PATH} && nohup ${BIN_PATH} --config ${CONFIG_PATH} > ${LOG_PATH} 2>&1 &

max_check_times=5
i=1
while (( i <= $max_check_times )) 
do
	health=$(curl -s http://localhost:10350/healthz)
	if [[ "$health" == "ok" ]]; then
		echo "The upgraded Edgecore's status is ok. Try to upgrade..."
        	ln -srf ${BIN_PATH} ${DEFAULT_BIN_PATH}
        	ln -srf ${CONFIG_PATH} ${DEFAULT_CONFIG_PATH}
                pkill edgecore && systemctl enable edgecore && systemctl daemon-reload && systemctl restart edgecore && sleep 3;
		echo "EdgeCore upgrades successfully..."
		break
	fi
	sleep 3;
done



