#!/bin/bash

iptables -A OUTPUT -d www.facebook.com -j DROP
# iptables -F
