#!/bin/bash

# Scrolling animated bicycle
# Adam Goldsmith

ride() {
  # USAGE: ride [display width (default: 8)] [speed (default: 0.1)]
  # speed is in seconds
  # Example: To ride the bike in a 10 character window at 1 character every 0.05 seconds...
  # ride 10 0.05
  # local window="${1:-8}"
  local bdata=(
    "   __o"
    " _ \<_"
  )
  local pdata=(
    "(_)/(_)"
    "(_)-(_)"
    "(_)\(_)"
    "(_)|(_)"
  )

  tput sc
  tput civis
  for i in $(seq 0 1 "${1:-8}")
  do
    tput rc
    for l in "${bdata[@]}"
    do
      printf "%*s%s\n" "${i}" "" "${l}"
    done
    printf "%*s%s\n" "${i}" "" "${pdata[$(( i % 4 ))]}"
    sleep "${2:-0.1}"
  done
  tput cvvis
}

ride 10 0.05

