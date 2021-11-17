#!/bin/bash

# Scrolling text

scroll() {
  # USAGE: scroll ["text to display" (default: "message")] [display window size (default: 4)] [speed (default: 0.1)] [direction (default: 0)] [restore cursor (default 0)]
  # speed is in seconds
  # direction: even is right to left, odd is left to right
  # restore_cursor: if non-zero puts the cursor back to the position when the function was called
  # Example: To scroll a message in a 10 character window at 1 character every 0.05 seconds backwards and put the cursor back to its original position...
  # scroll "This is my message!" 10 0.05 1 1
  local window="${2:-4}"
  local pad_message
  pad_message="$(printf "%*s%s%-*s" "${window}" "" "${1:-message}" "${window}" "")"
  local length="${#pad_message}"

  tput sc
  tput civis
  for i in $(seq 0 1 $(( length - window )))
  do
    # Reverse text flow if direction flag is not even number
    [[ $(( "${4:-0}" % 2 )) -ne 0 ]] && i=$(( length - window - i ))
    tput rc
    printf "[%s]" "${pad_message:i:window}"
    sleep "${3:-0.1}"
  done
  [[ "${5:-0}" -ne 0 ]] && tput rc
  tput cvvis
}

printf "Performing some task: "
for d in {1..4}
do
  scroll "." 3 0.05 ${d} 1
done

