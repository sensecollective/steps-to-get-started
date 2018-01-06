### Example of IPv6 ping

```
$ ping6 my.telegram.org

PING my.telegram.org(2001:67c:4e8:fa60:3:0:811:139 (2001:67c:4e8:fa60:3:0:811:139)) 56 data bytes
64 bytes from 2001:67c:4e8:fa60:3:0:811:139 (2001:67c:4e8:fa60:3:0:811:139): icmp_seq=1 ttl=53 time=431 ms
64 bytes from 2001:67c:4e8:fa60:3:0:811:139 (2001:67c:4e8:fa60:3:0:811:139): icmp_seq=2 ttl=53 time=400 ms
64 bytes from 2001:67c:4e8:fa60:3:0:811:139 (2001:67c:4e8:fa60:3:0:811:139): icmp_seq=3 ttl=53 time=375 ms
64 bytes from 2001:67c:4e8:fa60:3:0:811:139 (2001:67c:4e8:fa60:3:0:811:139): icmp_seq=4 ttl=53 time=706 ms
```

# if a system's access to this ping is blocked, then need to check 
# http://cipherdyne.org/blog/2009/07/iptables-script-update-logging-and-ipv6-issues.html
nmap -6 -P0 ::1
ip6tables -v -nL | grep DROP

