Introduce network latency by using Traffic control
```
[root@CF...tools]# tc qdisc add dev eth0 root netem delay 4.5ms

[root@CF...tools]# ruby db_ping_remote.rb <IP> 5432 root vmdb_production
Enter the password for database user root on host <IP>
Password: 
5.014530 ms
5.007255 ms
4.998477 ms
4.850548 ms
5.116484 ms

Average: 4.997459 ms
```

```
[root@CF...tools]# tc qdisc delete dev eth0 root netem delay 4.5ms
```

```
[root@CF...tools]# ruby db_ping_remote.rb <IP> 5432 root vmdb_production
Enter the password for database user root on host <IP>
Password:
0.354962 ms
0.387245 ms
0.370553 ms

```

### References 

1. https://unix.stackexchange.com/questions/83936/is-there-a-method-for-simulating-high-latency

2. https://wiki.linuxfoundation.org/networking/netem
