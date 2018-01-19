#!/bin/bash

for iface in `ip maddress | grep '^[0-9].*:' | awk '{print $2}'`; do echo $iface && ping -I $iface 8.8.8.8 -c 1 -W 2; done

