#!/usr/bin/expect

# Usage: 
#   $ ./automate_ssh-copy-id.sh

# Thanks: 
#   - http://stackoverflow.com/a/33499235/1332401

#################### CONFIG #######################
# Change the param values below, as per your setup.

# 'hostnames' file contains '\n' delimited list-of-hostnames
set HOSTNAMES "/home/arcolife/hostnames"
set SSH_PUB_KEY "/home/arcolife/.ssh/id_rsa.pub"
set USERNAME "root"
set PASSWD "changeme"
set TIME_OUT 20

# Following recommendation is not really a verified one,
# as I lack understanding of expect for now: 
#   => TIME_OUT should be: (10 * clients in hostnames)
#
#   - Try with a timout of 20 first, and then if it fails, 
#     remember to increase this script's timeout, i.e., 
#   - A 10 sec timeout failed for me, when I had 2 hosts 
#     in 'hostnames' file 

####################################################

set timeout $TIME_OUT
set f [open $HOSTNAMES]
set hosts [split [read -nonewline $f] "\n"]
close $f

foreach host $hosts {
    spawn ssh-copy-id -i $SSH_PUB_KEY $USERNAME@$host
    expect {
	"password:" {
	    send "$PASSWD\r"
	    exp_continue
	}
	"already exist on the remote system." {
            exp_continue
        }
    eof
    }
}

puts done

