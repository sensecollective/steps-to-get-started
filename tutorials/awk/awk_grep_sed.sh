log_start='2017-11-21T02:02'
log_end='2017-11-21T02:25'
 
 
less evm.log-20171121.gz | grep 'State\: \[ok\], Delivered in' > delivered
 
echo -e "$(awk -F'[]]|[[]| ' '$0 ~ /^\[----\] I, \[/ && $6 >= "'$log_start'" { p=1 }
                   $6 >= "'$log_end'" { p=0 } p { print $0 }' \
                   delivered )" > log_frag
 
cat log_frag |  grep -oE '(Message id: \[[0-9]*\])' |sed 's/Message id: \[//' | sed 's/.\{1\}$//' > ids
 
 
echo -e "$(less evm.log-20171121.gz | awk -F'[]]|[[]| ' '$0 ~ /^\[----\] I, \[/ &&
                   $6 >= "'$log_start'" { p=1 }
                   $6 >= "'$log_end'" { p=0 } p { print $0 }' \
                    )" > log_frag_detailed
 
touch completed
 
for current_id in `cat ids`; do grep '\['$current_id'\]' log_frag_detailed | sed -n -e 's/^.*Q-task_id.*\(Command:.*.]\), Timeout:.*/\1/p' >> completed; done
 
cat completed  | sort | uniq -c
-----------------
     50 Command: [ManageIQ::Providers::Redhat::InfraManager::Provision.poll_clone_complete]
    450 Command: [MiqAeEngine.deliver]
