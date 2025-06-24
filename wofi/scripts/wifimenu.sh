#!/bin/bash

FIELDS=NAME,TYPE,UUID
LIST=$(nmcli -f "$FIELDS" connection show | grep ethernet)
KNOWNCON=$(nmcli connection show)
CURRTYPE=$(nmcli -t -f NAME,TYPE connection show --active | grep ethernet)

if [[ ! -z $CURRTYPE ]]; then
    echo "CONNECTED"
fi