#!/usr/bin/env bash

ip rule add from 10.0.0.3 table 3
ip rule add from 10.0.0.4 table 4
ip route add 10.0.0.0/8 dev client2-eth0 scope link table 3
ip route add default via 10.0.0.20 dev client2-eth0 table 3
ip route add 10.0.0.0/8 dev client2-eth1 scope link table 4
ip route add default via 10.0.0.20 dev client2-eth1 table 4

