#!/bin/bash

# <config>
NUMBER=4
SYMBOL_CURRENT=""
SYMBOL_OTHER=""
PIPE="$HOME/.cache/wspace"
WRAP=true
# </config>

# format_line takes the current workspace number [1..N] and prints a string
# representing the list of workspaces (e.g. 4 -> "0 0 0 1 0")
format_line() {
    before=`yes $SYMBOL_OTHER 2>/dev/null | head -n $(($1 - 1))`
    after=`yes $SYMBOL_OTHER 2>/dev/null | head -n $(($NUMBER - $1))`
    echo $before $SYMBOL_CURRENT $after
}

# remove an existing pipe and make a new one
rm -f $PIPE
mkfifo $PIPE

# print initial state
current=1
format_line $current

while true
do
    if read input <$PIPE; then
        if [ $input == "1" ]; then input=$((current + 1)); fi
        if [ $input == "2" ]; then input=$((current - 1)); fi

        if (( $input < 1 )); then
            if [ "$WRAP" == false ]; then continue; fi
            input=$NUMBER
        fi
        if (( $input > $NUMBER )); then
            if [ "$WRAP" == false ]; then continue; fi
            input=1
        fi
        if (( $input == $current )); then continue; fi

        format_line $input
        current=$input
    fi
done
