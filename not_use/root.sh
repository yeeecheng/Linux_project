#!/usr/bin/expect



set timeout 1

spawn sudo bash /home/yi-cheng/linux_hw/sh/autoUpdate.sh 

expect "Password"
send "a1095551\r"

interact

