#!/bin/sh

zenity --forms --title="Add Friend" \
    --text="Enter information about your friend." \
    --separator="," \
    --add-entry="First Name" \
    --add-entry="Family Name" \
    --add-entry="Email" \
    --add-calendar="Birthday" >> addr.csv

case $? in
    0)
        echo "Friend added. Check addr.csv";;
    1)
        echo "No friend added."
	;;
    -1)
        echo "An unexpected error has occurred."
	;;
esac
