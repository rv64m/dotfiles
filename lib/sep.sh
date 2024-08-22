#!/bin/bash

# Function to print a full-screen separator with centered text
print_separator() {
    local text="$1"
    local columns=$(tput cols)
    local lines=$(tput lines)
    local text_length=${#text}
    local padding_length=$(( (columns - text_length) / 2 ))
    local separator_line=$(printf '%*s' "$columns" | tr ' ' '=')

    # Clear the screen
    clear

    # Print empty lines to center vertically
    local empty_lines=1
    for ((i=0; i<empty_lines; i++)); do
        echo
    done

    # Print a single line with separator and centered text
    printf "%s\n" "${separator_line:0:$padding_length} $text ${separator_line:$padding_length+$text_length+2}"

    # Print remaining empty lines
    # for ((i=0; i<1; i++)); do
    #     echo
    # done
}

# Usage example
# print_separator "Your Text Here"
