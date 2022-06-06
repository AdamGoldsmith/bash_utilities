#!/bin/bash

# Scrolling animated bicycle
# Adam Goldsmith

ride() {
  # USAGE: ride [display width (default: 8)] [speed (default: 0.1)] [acceleration (default: 0%)]
  # speed is in seconds
  # accelerates to a maximum speed of 5 frames per second (1 per 0.2 secs)
  # Example: To ride the bike in a 80 character window at 1 character every 0.4 seconds with 5% acceleration...
  # ride 80 0.4 5
  local bdata=(
    "   __o"
    " _ \<_"
  )
  local pdata=(
    '/'
    '-'
    '\'
    '|'
  )
  local speed="${2:-0.1}"
  local acc
  acc=$(bc <<< "scale=2; 1-${3:-0}/100")

  tput sc
  tput civis
  for i in $(seq 0 1 "${1:-8}")
  do
    tput rc
    for l in "${bdata[@]}"
    do
      printf "%*s%s\n" "${i}" "" "${l}"
    done
    printf "%*s(_)%s(_)\n" "${i}" "" "${pdata[$(( i % 4 ))]}"
    sleep "${speed}"
    # Have to divide by 1 to reset the scale - see bc documentation
    [[ $(bc <<< "${speed}*100/1") -gt 1 ]] && speed=$(bc <<< "scale=4; ${speed}*${acc}")
  done
  tput cvvis
}

ride 80 0.4 5

