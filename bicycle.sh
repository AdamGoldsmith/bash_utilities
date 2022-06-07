#!/bin/bash

# Scrolling animated bicycle
# Adam Goldsmith

ride() {
  # USAGE: ride [display width (default: 20)] [speed (default: 0.1)] [acceleration (default: 0%)]
  # speed is in seconds
  # accelerates to a maximum speed of 5 frames per second (1 per 0.2 secs)
  # Example: To ride the bike in a 80 character window at 1 character every 0.4 seconds with 5% acceleration...
  # ride 80 0.4 5
  local window="${1:-20}"
  local bdata=('   __o' ' _ \<_')
  local pdata=('(_)/(_)' '(_)-(_)' '(_)\(_)' '(_)|(_)')
  local speed="${2:-0.1}"
  local acc; acc=$(bc <<< "scale=2; 1-${3:-0}/100")
  # Pad arrays to simplify printing using printf's substr parameters
  for b in "${!bdata[@]}"
  do
    bdata[${b}]="$(printf "%*s%s%-*s" "${window}" "" "${bdata[${b}]}" "${window}" "")"
  done
  for p in "${!pdata[@]}"
  do
    pdata[${p}]="$(printf "%*s%s%-*s" "${window}" "" "${pdata[${p}]}" "${window}" "")"
  done
  local length="${#pdata[0]}"

  printf "\n\n\n"
  tput cuu1; tput cuu1; tput cuu1
  tput sc
  tput civis
  for i in $(seq 0 1 $(( length - window )))
  do
    tput rc
    for b in "${bdata[@]}"
    do
      printf "%s\n" "${b:$(( length - window - i )):window}"
    done
    printf "%s" "${pdata[$(( i % 4 ))]:$(( length - window - i )):window}"
    sleep "${speed}"
    # Have to divide by 1 to reset the scale - see bc documentation
    [[ $(bc <<< "${speed}*100/1") -gt 1 ]] && speed=$(bc <<< "scale=4; ${speed}*${acc}")
  done
  tput cvvis
  printf "\n"
}

ride 80 0.4 5
