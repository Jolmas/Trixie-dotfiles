#!/bin/bash

# <config>
NUMBER=5
SYMBOL_CURRENT=""
SYMBOL_OTHER=""
PIPE=/home/luis/.cache/workspace
WRAP=true
# </config>

# format_line takes the current workspace number [1..N] and prints a string
# representing the list of workspaces (e.g. 4 -> "    ")
format_line() {
    local current_workspace=$1
    local output=""
    for ((i=1; i<=NUMBER; i++)); do
        if (( i == current_workspace )); then
            output+="$SYMBOL_CURRENT "
        else
            output+="$SYMBOL_OTHER "
        fi
    done
    echo "$output"
}

# remove an existing pipe and make a new one
rm -f "$PIPE"
mkfifo "$PIPE"

# print initial state
current=1
format_line "$current"

while true; do
    if read -r input <"$PIPE"; then
        # Check if the input is a number
        if [[ "$input" =~ ^[0-9]+$ ]]; then
            # Cast the input to an integer
            input_num=$input
        else
            # If the input is not a number, handle special cases
            if [[ "$input" == "1" ]]; then
                input_num=$((current + 1))
            elif [[ "$input" == "2" ]]; then
                input_num=$((current - 1))
            else
                continue # Ignore invalid input
            fi
        fi

        # Check for wrapping
        if (( input_num < 1 )); then
            if [[ "$WRAP" == "false" ]]; then
                continue
            fi
            input_num=$NUMBER
        fi
        if (( input_num > NUMBER )); then
            if [[ "$WRAP" == "false" ]]; then
                continue
            fi
            input_num=1
        fi

        # Check if the workspace has changed
        if (( input_num == current )); then
            continue
        fi

        # Update and print the new state
        format_line "$input_num"
        current=$input_num
    fi
done
