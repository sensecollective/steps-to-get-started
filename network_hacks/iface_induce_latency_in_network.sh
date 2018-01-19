# # ruby /var/www/miq/vmdb/tools/db_ping_remote.rb 10.12.23.201 5432 root vmdb_production
# Enter the password for database user root on host 10.12.23.201
# Password:
# 0.554313 ms
# 0.521914 ms
# 0.295849 ms
# 0.222224 ms
# 0.276519 ms
#
# Average: 0.374164 ms

# [.. tools]# tc qdisc delete dev eth0 root netem delay 4.5ms
# [.. tools]# tc qdisc add dev eth0 root netem delay 4.5ms

# =====================================
# # ruby db_ping_remote.rb <IP> 5432 root vmdb_production
# Enter the password for database user root on host <IP>
# Password:
# 0.354962 ms
# 0.387245 ms
# 0.370553 ms
# ==========================

