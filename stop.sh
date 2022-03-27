#!/bin/bash

health=$(curl -s http://localhost:10350/healthz)
if [[ "$health" != "ok" ]]; then
	echo "Restart Older Edgecore..."
	pkill edgecore && systemctl enable edgecore && systemctl daemon-reload && systemctl restart edgecore
fi

