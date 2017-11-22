OS_RELEASE=$(lsb_release -i | awk '{print $NF}')
# OTHER_CMD=$(which <other installer>)

if [[ $OS_RELEASE == 'Fedora' ]]; then
    packages_count=$(rpm -q python3-devel gpgme-devel gpgme | wc -l)
    echo 1
    if [[ ! $packages_count -eq 3 ]]; then
	    echo 2
        echo "Need sudo permission for installing python3 devel and gpgme/devel packages"
        sudo dnf -y install python3-devel gpgme-devel gpgme
    fi
elif [[ $OS_RELEASE == 'Ubuntu' ]]; then
	echo 3
    packages_status=$(dpkg -l libgpgme11 libgpgme11-dev python3-dev | grep 'no packages found')
    if [[ ! -z $packages_status ]]; then
	    echo 4
        echo "Need sudo permission for installing python3 devel and gpgme/devel packages"
        sudo apt-get install -y install libgpgme11 libgpgme11-dev python3-gpgme python3-dev
    fi
else
	echo 5
    echo "error can't install a few packages."
    echo "kindly edit this script to add your package manager in 'OTHER_CMD='"
    exit 1;
fi
echo 6
