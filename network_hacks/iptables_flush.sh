#!/bin/sh
echo "Flushing iptables rules..."
sleep 1
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables-save

iptables-restore
##################################
# There rules will lock down the 
# machine and if you are connecting 
# from a remote ssh session you wont
# connect.
##################################
# recommend these rules instead

# iptables -P INPUT ACCEPT
# iptables -F
# iptables -A INPUT -i lo -j ACCEPT
# iptables -A INPUT -m state –state ESTABLISHED,RELATED -j ACCEPT
# iptables -A INPUT -p tcp –dport 22 -j ACCEPT
# iptables -P INPUT DROP
# iptables -P FORWARD DROP
# iptables -P OUTPUT ACCEPT
# iptables -L -v



#############################
## use this to forward http traffic to a transparent proxy

# iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to 9090
