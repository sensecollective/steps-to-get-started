## OSP

### CFME side
```
iptables -A OUTPUT -t nat -d 192.0.2.1 -j DNAT --to-destination 10.16.154.6
iptables -A OUTPUT -t nat -d 172,21,0.10 -j DNAT --to-destination 10.16.154.9
```

### OSP side

```
# Undercloud

# list all endpoint ports
$ for i in `openstack endpoint list | awk -F'| ' '{ print $2}' | sed 1,3d | sed '/^$/d'`; do openstack endpoint show $i | grep admin; done > endpoint_ports
$ cat endpoint_ports |  sed '/^$/d' | awk -F':' '{ print $3}' |  sed '/^$/d' | awk -F'/| ' '{ print $1}' > ports_new
# | cut -c 1-4 | sort | uniq

# do an additional step for 5000 port (not included in ports_new from above steps)
iptables -t nat -A PREROUTING -i em1 -p tcp --dport 5000 -j DNAT --to-destination 192.0.2.1:5000

$ for i in `cat ports_new`; do sudo iptables -t nat -A PREROUTING -i em1 -p tcp --dport $i -j DNAT --to-destination 192.0.2.1:$i; done

for i in {1..13}; do sudo iptables -t nat -D PREROUTING 5; done

same for overcloud controller

# additional step
$ sudo iptables -t nat -A PREROUTING -i br-ex -p tcp --dport 5000 -j DNAT --to-destination 192.0.2.11:5000

$ sudo iptables -t nat -L -n -v --line-numbers

for i in {1..13}; do sudo iptables -t nat -D PREROUTING 2; done

--------------------------

cat fog.log | grep 192.0.2.1 | grep adminURL | awk -F':' '{print $NF}' | awk -F'"|/' '{print $1}' | sort | uniq
35357


iptables -t nat -L -n -v --line-numbers 
iptables -t nat -D PREROUTING 1
--------------

total ip forward from source (local IP) to destinate (192.0.2.1) and thrugh 10.16.154.3

 iptables -t nat -A PREROUTING -d 192..... -j DNAT --to-destination 10.10.14.2
--------------
iptables -A OUTPUT -t nat -d 192.0.2.1 -j DNAT --to-destination 10.16.154.6


================================

[root@gprfc002 ~]# cat stackrc 
NOVA_VERSION=1.1ps	
export NOVA_VERSION
OS_PASSWORD=$(sudo hiera admin_password)
export OS_PASSWORD
OS_AUTH_URL=http://192.0.2.1:5000/v2.0
export OS_AUTH_URL
OS_USERNAME=admin
OS_TENANT_NAME=admin
COMPUTE_API_VERSION=1.1
OS_BAREMETAL_API_VERSION=1.15
OS_NO_CACHE=True
OS_CLOUDNAME=undercloud
OS_IMAGE_API_VERSION=1
export OS_USERNAME
export OS_TENANT_NAME
export COMPUTE_API_VERSION
export OS_BAREMETAL_API_VERSION
export OS_NO_CACHE
export OS_CLOUDNAME
export OS_IMAGE_API_VERSION

--------
cat overcloudrc.back 
# Clear any old environment that may conflict.
for key in $( set | awk '{FS="="}  /^OS_/ {print $1}' ); do unset $key ; done
export OS_NO_CACHE=True
export OS_CLOUDNAME=overcloud
export OS_AUTH_URL=http://192.0.2.9:5000/v2.0
export NOVA_VERSION=1.1
export COMPUTE_API_VERSION=1.1
export OS_USERNAME=admin
export OS_PASSWORD=6PecAgmCYjKnG9ReHuuvDbGnQ
#export no_proxy=,10.0.0.103,192.168.24.9
export OS_PROJECT_NAME=admin
export PYTHONWARNINGS="ignore:Certificate has no, ignore:A true SSLContext object is not available"

-------------

sudo iptables -t nat -A PREROUTING -i em1 -p tcp --dport 5000 -j DNAT --to-destination 192.0.2.1:5000

[root@gprfc002 ~]# iptables -t nat -L -n -v --line-numbers 
Chain PREROUTING (policy ACCEPT 15542 packets, 2853K bytes)
num   pkts bytes target     prot opt in     out     source               destination         
1     7660  460K DNAT       tcp  --  em1    *       0.0.0.0/0            0.0.0.0/0            tcp dpt:5000 to:192.0.2.1:5000

Chain INPUT (policy ACCEPT 12977 packets, 1037K bytes)
num   pkts bytes target     prot opt in     out     source               destination         

Chain OUTPUT (policy ACCEPT 73001 packets, 4801K bytes)
num   pkts bytes target     prot opt in     out     source               destination         

Chain POSTROUTING (policy ACCEPT 77033 packets, 5050K bytes)
num   pkts bytes target     prot opt in     out     source               destination 

-------------
[root@gprfc002 ~]# route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         10.16.159.254   0.0.0.0         UG    100    0        0 em1
10.16.36.29     10.16.159.254   255.255.255.255 UGH   100    0        0 em1
10.16.152.0     0.0.0.0         255.255.248.0   U     100    0        0 em1
169.254.0.0     0.0.0.0         255.255.0.0     U     1003   0        0 em2
169.254.0.0     0.0.0.0         255.255.0.0     U     1007   0        0 br-ctlplane
172.17.0.0      0.0.0.0         255.255.0.0     U     0      0        0 docker0
172.123.10.0    0.0.0.0         255.255.255.0   U     100    0        0 p1p1
192.0.2.0       0.0.0.0         255.255.255.0   U     0      0        0 br-ctlplane
-----------------

 248  curl 192.0.2.1:5000
  249  clear
  250  ifconfig
  251  curl 192.0.2.1:5000
  252  curl 10.16.154.3:5000
  253  route -n
  254  route -n > /tmp/rouute
  255  cat /tmp/rouute 
  256  iptables -t nat -I POSTROUTING -s 192.0.2.1/24 SNAT --to-source 10.16.154.3 
  257  iptables -t nat -I POSTROUTING -s 192.0.2.1/24 SNAT -j --to-source 10.16.154.3 
  258  iptables -t nat -I POSTROUTING -s 192.0.2.1/24 -j SNAT --to-source 10.16.154.3 
  259  echo 1 > /proc/sys/net/ipv4/ip_forward
  260  sudo echo 1 > /proc/sys/net/ipv4/ip_forward
  261  sudo iptables -t nat -I POSTROUTING -s 192.0.2.1/24 -j SNAT --to-source 10.16.154.3
  262  sudo echo 1 > /proc/sys/net/ipv4/ip_forward
  263  echo 1 > /proc/sys/net/ipv4/ip_forward
  264  sudo echo 1 > /proc/sys/net/ipv4/ip_forward
  265  cat /proc/sys/net/ipv4/ip_forward
  266  cat /proc/sys/net/bridge/bridge-nf-call-iptables
  267  route -n
  268  curl 10.16.154.3:5000


=================================================================
new vm rhvm OSP

assign 3 nics (cfme-perf does that while launching vm)
[btw add --mac hack to cfme-perf ]

==============

add 3 interfaces to network-scripts
==============
change MAC address from RHVM GUI

==============
[root@vm1 network-scripts]# cat /etc/resolv.conf 
search rdu.openstack.engineering.redhat.com
nameserver 10.12.64.161
nameserver 10.12.64.173
nameserver 10.12.69.254

or do this:
echo  -e "search rdu.openstack.enginee10.ring.redhat.com
nameserver 10.12.64.161
nameserver 10.12.64.173
nameserver 10.12.69.254
" | resolvconf -a eth1.inet

or this
service network restart

also, firewalld restart and setenforce 0
==============

ifdown/up eth0.10, eth1, eth0
stop firewalld

ping 8.8.8.8 / dl.fedoraproject.org
==============
check if semanage needed
============
run postconfig
===========
```
