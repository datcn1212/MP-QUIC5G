#!/usr/bin/env bash

tc qdisc add dev client2-eth0 root handle 5:0 hfsc default 1
tc class add dev client2-eth0 parent 5:0 classid 5:1 hfsc sc rate 20Mbit ul rate 30Mbit

tc qdisc add dev client2-eth1 root handle 5:0 hfsc default 1
tc class add dev client2-eth1 parent 5:0 classid 5:1 hfsc sc rate 90Mbit ul rate 100Mbit

tc qdisc add dev client2-eth0 parent 5:1 netem loss 0.5% delay 20ms 1ms distribution pareto
tc qdisc add dev client2-eth1 parent 5:1 netem loss 0.8% delay 30ms 1ms distribution pareto
