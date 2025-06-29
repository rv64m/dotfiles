#!/bin/bash

# =================================================================
# Common Function Library (v1)
#
# Features:
# 1. Defines color output for logs and highlighting.
# 2. Provides logging functions with timestamps and levels (info, success, warn, error).
# 3. Provides a simple text progress bar.
# =================================================================

# --- Color output definitions ---
COLOR_RESET='[0m'
COLOR_GREEN='[0;32m'
COLOR_YELLOW='[0;33m'
COLOR_BLUE='[0;34m'
COLOR_RED='[0;31m'
COLOR_CYAN='[0;36m'

# --- Emoji definitions ---
EMOJI_ROCKET="🚀"
EMOJI_CHECK="✅"
EMOJI_WARN="⚠️"
EMOJI_ERROR="❌"
EMOJI_PARTY="🎉"
EMOJI_POINT="👉"

# --- Logging functions ---

# Internal log implementation
_log() {
    local level_color="$1"
    local level_text="$2"
    local message="$3"
    # Print log with color and timestamp
    echo -e "${level_color}[${level_text}] $(date '+%H:%M:%S'): ${message}${COLOR_RESET}"
}

# Public logging functions
log_info() {
    _log "$COLOR_BLUE" "INFO" "$1"
}

log_success() {
    _log "$COLOR_GREEN" "SUCCESS" "$1"
}

log_warn() {
    _log "$COLOR_YELLOW" "WARN" "$1"
}

log_error() {
    _log "$COLOR_RED" "ERROR" "$1"
}

log_step() {
    echo -e "
${COLOR_CYAN}--- $1 ---${COLOR_RESET}"
}


# --- Progress bar function ---

# Display a simple text progress bar
# Parameter 1: current progress (integer)
# Parameter 2: total progress (integer)
# Parameter 3: progress bar width (number of characters)
show_progress() {
    local current=$1
    local total=$2
    local width=${3:-50} # Default to 50 characters wide

    # Calculate percentage
    local percent=$((current * 100 / total))
    
    # Calculate the length of the completed part
    local completed_width=$((width * percent / 100))
    
    # Build the progress bar string
    local progress_bar=""
    for ((i=0; i<completed_width; i++)); do
        progress_bar+="="
    done
    
    # Fill the remaining part
    for ((i=completed_width; i<width; i++)); do
        progress_bar+=" "
    done
    
    # Print the progress bar, use  to return to the beginning of the line to achieve dynamic update
    echo -ne "  [${progress_bar}] ${percent}% (${current}/${total})"
    
    # If completed, new line
    if [ "$current" -eq "$total" ]; then
        echo ""
    fi
}

# --- Example usage ---
# log_info "This is a message."
# log_success "Operation successful!"
# log_warn "This is a warning."
# log_error "An error occurred."
# log_step "Initializing operation"
#
# echo "Simulating a time-consuming operation:"
# for i in {0..20}; do
#     show_progress $i 20 40
#     sleep 0.1
# done
# log_success "Simulation complete."