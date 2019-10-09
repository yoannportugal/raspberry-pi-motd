#!/bin/bash

let upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
let secs=$((${upSeconds}%60))
let mins=$((${upSeconds}/60%60))
let hours=$((${upSeconds}/3600%24))
let days=$((${upSeconds}/86400))
UPTIME=`printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs"`

MEM=`free -m | awk 'NR==2 { printf "Total: %sMB, Used: %sMB, Free: %sMB",$2,$3,$4; }'`
DISK=`df -h ~ | awk 'NR==2 { printf "Total: %sB, Used: %sB, Free: %sB",$2,$3,$4; }'`
TEMP=`/opt/vc/bin/vcgencmd measure_temp | cut -c "6-9"`
VAR_IP_INTERN="$(hostname -I)"
THROTTLED=`/opt/vc/bin/vcgencmd get_throttled`
# get the load averages
read one five fifteen rest < /proc/loadavg

DARKGREY="$(tput sgr0 ; tput bold ; tput setaf 0)"
RED="$(tput sgr0 ; tput setaf 1)"
GREEN="$(tput sgr0 ; tput setaf 2)"
YELLOW="$(tput sgr0 ; tput setaf 3)"
BLUE="$(tput sgr0 ; tput setaf 4)"
WHITE="$(tput sgr0 ; tput setaf 7)"
NC="$(tput sgr0)" # No Color

echo "${GREEN}
   .~~.   .~~.    ${YELLOW}`hostname -f`${GREEN}
  '. \ ' ' / .'   ${YELLOW}`date +"%A, %e %B %Y, %H:%M:%S"`${RED}
   .~ .~~~..~.
  : .~.'~'.~. :   ${DARKGREY}Uptime.............: ${WHITE}${UPTIME}${RED}
 ~ (   ) (   ) ~  ${DARKGREY}Memory.............: ${WHITE}${MEM}${RED}
( : '~'.~.'~' : ) ${DARKGREY}Disk usage.........: ${WHITE}${DISK}${RED}
 ~ .~ (   ) ~. ~  ${DARKGREY}Load Averages......: ${WHITE}${one}, ${five}, ${fifteen} (1, 5, 15 min)${RED}
  (  : '~' :  )   ${DARKGREY}Running Processes..: ${WHITE}`ps ax | wc -l | tr -d " "`${RED}
   '~ .~~~. ~'    ${DARKGREY}IP Addresses.......: ${WHITE}${VAR_IP_INTERN}${RED}
       '~'        ${DARKGREY}Temperature........: ${WHITE}${TEMP}ºC${RED}
                  ${DARKGREY}Throttled..........: ${WHITE}${THROTTLED}${RED}
${NC}"
