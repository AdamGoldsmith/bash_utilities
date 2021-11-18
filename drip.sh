#!/bin/bash

# Drip animation
# Adam Goldsmith

drip() {
  # USAGE: drip [drips (default: 1)] [speed (default: 0.2)] [keep drip (default 0)]
  # drips is number of drip animations
  # speed is in seconds
  # keep drip: if non-zero keeps last drip character on-screen by moving cursor to the right
  # Example: To have five drips at 1 character every 0.1 seconds and keep the drip on screen
  # drip 5 0.1 1
  local chars=("'" "!" ":" "." "," "_")

  tput civis
  for _ in $(seq 1 "${1:-1}")
  do
    for c in "${chars[@]}"
    do
      printf "%s" "${c}"
      tput cub 1
      sleep "${2:-0.2}"
    done
  done
  tput cvvis
  [[ "${3:-0}" -ne 0 ]] && tput cuf 1
}

# Example usage..
# Drip 10 times from random area inside 40 character window
for _ in {0..9}
do
  rand=$(shuf -i 0-40 -n1)
  printf "%*s" "${rand}" ""
  drip
  tput el1
  tput cub "${rand}"
done

