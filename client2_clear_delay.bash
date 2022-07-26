#!/usr/bin/env bash

echo "Clearing delays on client2-eth0"
tc qdisc del dev client2-eth0 parent 5:1
