#!/bin/bash

# Determine the operating system
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    echo "Detected macOS. Running developer_macos.sh..."
    bash "$(dirname "$0")/dev_mac.sh"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    echo "Detected Linux. Running developer_linux.sh..."
    bash "$(dirname "$0")/dev_linux.sh"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    # Windows
    echo "Detected Windows. Running developer_windows.sh..."
    bash "$(dirname "$0")/dev_win.sh"
else
    echo "Unsupported operating system: $OSTYPE"
    exit 1
fi

