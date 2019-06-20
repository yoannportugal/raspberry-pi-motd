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

# get the load averages
read one five fifteen rest < /proc/loadavg

DARKGREY="$(tput sgr0 ; tput bold ; tput setaf 0)"
RED="$(tput sgr0 ; tput setaf 1)"
GREEN="$(tput sgr0 ; tput setaf 2)"
YELLOW="$(tput sgr0 ; tput setaf 3)"
BLUE="$(tput sgr0 ; tput setaf 4)"
NC="$(tput sgr0)" # No Color

echo "${GREEN}
   .~~.   .~~.    ${YELLOW}`hostname -f`${GREEN}
  '. \ ' ' / .'   ${YELLOW}`date +"%A, %e %B %Y, %r"`${RED}
   .~ .~~~..~.
  : .~.'~'.~. :   ${DARKGREY}Uptime.............: ${BLUE}${UPTIME}${RED}
 ~ (   ) (   ) ~  ${DARKGREY}Memory.............: ${BLUE}${MEM}${RED}
( : '~'.~.'~' : ) ${DARKGREY}Disk usage.........: ${BLUE}${DISK}${RED}
 ~ .~ (   ) ~. ~  ${DARKGREY}Load Averages......: ${BLUE}${one}, ${five}, ${fifteen} (1, 5, 15 min)${RED}
  (  : '~' :  )   ${DARKGREY}Running Processes..: ${BLUE}`ps ax | wc -l | tr -d " "`${RED}
   '~ .~~~. ~'    ${DARKGREY}IP Addresses.......: ${BLUE}`hostname -I`${RED}
       '~'        ${DARKGREY}Temperature........: ${BLUE}${TEMP}ºC${RED}
${NC}"
