# dns problem

# add google DNS to system
# https://developers.google.com/speed/public-dns/docs/using#testing
echo '8.8.8.8' >> /etc/resolv.conf 

# that's a temporary solution. On network manager restart, it would be overrided.
# https://unix.stackexchange.com/a/90061/17744
