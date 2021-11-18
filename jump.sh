#!/bin/bash

# Jump animation
# Adam Goldsmith

jump() {
  # USAGE: jump [jumps (default: 1)] [speed (default: 0.2)]
  # jumps is number of jump animations
  # speed is in seconds
  # Example: To have five jumps at 1 character every 0.1 seconds
  # jump 5 0.1
  local l_chars=("." ":")
  local m_chars=("/" "-" "\\")
  local r_chars=(":" ".")

  tput civis
  for _ in $(seq 1 "${1:-1}")
  do
    for c in "${l_chars[@]}"
    do
      printf "%s" "${c}"
      tput cub 1
      sleep "${2:-0.2}"
    done
    printf " "

    for c in "${m_chars[@]}"
    do
      printf "%s" "${c}"
      tput cub 1
      sleep "${2:-0.2}"
      printf " "
    done

    for c in "${r_chars[@]}"
    do
      printf "%s" "${c}"
      tput cub 1
      sleep "${2:-0.2}"
    done
  done
  tput cvvis
}

jump 5 0.1

