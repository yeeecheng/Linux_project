#!/usr/bin/expect

set SCRIPT_DIR [file dirname [file normalize [info script]]]

set LOG_FILE "$SCRIPT_DIR/../log/autoUpdate.log"

spawn sudo sh -c "apt-get update && apt-get upgrade -y --show-progress" > "$LOG_FILE" 2>&1

expect "*password*" {

	send "a1095551\r"

}

expect eof

if {[catch {wait} result]} {

	puts "System update failed."
	puts "Check $LOG_FILE to get the error info."
	exec tail -n 10 "$LOG_FILE"

} else {
	set DATE [exec date "+%Y-%m-%d %H:%M:%S"]
	set TEMP_FILE [open "$LOG_FILE.tmp" "w"]
	puts $TEMP_FILE "System update complete at $DATE." 
	close $TEMP_FILE
	exec mv -f "$LOG_FILE.tmp" "$LOG_FILE"
}
