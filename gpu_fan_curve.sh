#!/bin/bash
# script for a simple nvidia gpu fan curve using nvidia-settings
nvidia-settings -a GPUFanControlState[gpu:0]=1 &> /dev/null

change_fan_speed () {
		speed=$1
		echo $temp
	    nvidia-settings -a GPUTargetFanSpeed[fan:0]=$speed &> /dev/null
	    echo 'set fan speed to '$speed' %'
		return
}

while true; do
	temp=$(nvidia-settings -q GPUCoreTemp -t 2> /dev/null | grep -E "[1-9]" -m 1)
	case "$temp" in
			  [0-3][0-9]) change_fan_speed 15 ;;
			  [4-5][0-9]) change_fan_speed 20 ;;
			  [6-7][0-9]) change_fan_speed 45 ;;
			  *) change_fan_speed 60 ;;
	esac
	sleep 4
done
