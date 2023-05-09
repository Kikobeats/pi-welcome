let upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
let secs=$((${upSeconds}%60))
let mins=$((${upSeconds}/60%60))
let hours=$((${upSeconds}/3600%24))
let days=$((${upSeconds}/86400))
UPTIME=`printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs"`

# get the load averages
read one five fifteen rest < /proc/loadavg

# mem stats
usedRAM=$(free | awk '/Mem/{printf("%.2f\n"), $3/1024}')
totalRAM=$(free | awk '/Mem/{printf("%.2f\n"), $2/1024}')
gpu=$(vcgencmd measure_temp | sed 's/temp=//' | sed "s/'C/ C/")

cpu=$(</sys/class/thermal/thermal_zone0/temp)
cpu="$(($cpu/1000)) C"
volts=$(vcgencmd measure_volts core | cut -d'=' -f 2)

freq=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq | awk '{printf("%.0f\n"), $1/1000}')
freq=$((freq))



echo "$(tput setaf 2)
   .~~.   .~~.    `date +"%A, %e %B %Y, %r"`
  '. \ ' ' / .'   `uname -srmo`$(tput setaf 1)
   .~ .~~~..~.
  : .~.'~'.~. :   Uptime.............: ${UPTIME}
 ~ (   ) (   ) ~  Memory.............: ${usedRAM} MB (used) / ${totalRAM} MB (total)
( : '~'.~.'~' : ) CPU................: ${freq} MHz / ${cpu} / ${volts} (volts)
 ~ .~ (   ) ~. ~  GPU................: ${gpu}
  (  : '~' :  )   Load Averages......: ${one}, ${five}, ${fifteen} (1, 5, 15 min)
   '~ .~~~. ~'    Running Processes..: `ps ax | wc -l | tr -d " "`
       '~'        Local IP Addresses.: `hostname -I`
                  WAN IP Address.....: `wget -q -O - http://icanhazip.com/ | tail`
$(tput sgr0)"