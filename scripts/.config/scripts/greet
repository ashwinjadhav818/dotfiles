#!/bin/sh
## hostname
host=$(hostname)

## os (distro)
if [ "$(uname -o)" = "Msys" ]; then
    PRETTY_NAME="Windows"
else
    read -r kernel < /proc/sys/kernel/osrelease
    . /etc/os-release
fi

## wm
if [ -n "$DISPLAY" ] && command -v xprop >/dev/null 2>&1; then
    id=$(xprop -root -notype _NET_SUPPORTING_WM_CHECK)
    id=${id##* }
    wm=$(xprop -id "$id" -notype -len 100 -f _NET_WM_NAME 8t |
        grep '^_NET_WM_NAME' | cut -d\" -f 2)
elif [ "$(uname -o)" = "Msys" ]; then
    wm="Aero" 
fi

## kernel
ke=$(uname -s -r)

## colors
magenta='[35m'
cyan='[36m'
white='[37m'
reset='[0m'

## output
printf '%s\n' "
  ${cyan}os${white} ~ ${PRETTY_NAME}
  ${cyan}sh${white} ~ ${SHELL##*/}
  ${cyan}wm${white} ~ ${wm}

  ʕ•ᴥ•ʔ welcome to ${magenta}${host}${reset}, ${magenta}${USER}${reset}
"
