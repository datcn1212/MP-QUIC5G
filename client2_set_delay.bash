#!/usr/bin/env bash

./scripts/client2_clear_delay.bash
echo "Setting delay "$1" for client2-eth0"
tc qdisc add dev client2-eth0 parent 5:1 netem loss 1.19% delay $1ms 1ms
