
echo "[----] I, [2017-11-30T02:45:39.660501 #38294:eb1130]  INFO -- : MIQ(MiqQueue#delivered) Message id: [9467], State: [ok], Delivered in [0.148169275] seconds" > /tmp/evm.log

# if log is in EST
time_last=$(tail -1 /tmp/evm.log  | sed -n -e 's/^.*I, \[\(.*\) #.*\].*/\1/p' | awk -F'.' '{print$1}')

# in EST
log_end=`TZ=America/New_York date -d "$time_last"`

echo "DATE: $log_end"
# 2017-11-30T02:45:39

# add
echo -e "\nAdding 1 hour..."
TZ=America/New_York date --date="${log_end} + 1 hour" +'%Y-%m-%dT%H:%M:%S'
# 2017-11-30T08:15:39

# subtract
echo -e "\nSubtracting 1 hour with direct value..."
TZ=America/New_York date --date="${log_end} - 1 hour" +'%Y-%m-%dT%H:%M:%S'
# 2017-11-30T10:15:39


# subtract using variable
ONE=1
echo -e "\nSubtracting 1 hour with variable substitution..."
TZ=America/New_York date -d "${log_end} - ${ONE} hour" +'%Y-%m-%dT%H:%M:%S'
# 2017-11-30T10:15:39

# subtract with bash params / WRONG
# date -d "${log_end} - ${4} hour" +'%Y-%m-%dT%H:%M:%S'
# 2017-11-30T03:45:39

# end=`TZ=America/New_York date -d "$log_end"`


rm /tmp/evm.log
