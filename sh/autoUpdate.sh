#!/usr/bin/expect

set SCRIPT_DIR [file dirname [file normalize [info script]]]

set LOG_FILE "$SCRIPT_DIR/../log/autoUpdate.log"

spawn sudo sh -c "apt-get update && apt-get upgrade -y --show-progress" >> "$LOG_FILE" 2>&1

expect "*password*" {

	send "a1095551\r"

}

expect eof

if {[catch {wait} result]} {

	puts "System update failed."
	puts "Check $LOG_FILE to get the error info."
	exec tail -n 10 "$LOG_FILE"

} else {
	puts "System update complete."
}
