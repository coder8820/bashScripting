#!/usr/bin/env bash
section "SYSTEM AUDIT"

echo "Hostname      : $(hostname 2>/dev/null || echo "Unknown")"
echo "Current User  : $(id -un 2>/dev/null || echo "Unknown")"
echo "Kernel        : $(uname -sr 2>/dev/null || echo "Unknown")"

if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    echo "Operating Sys : ${PRETTY_NAME:-Unknown}"
else
    echo "Operating Sys : Unknown"
fi

echo "Uptime        : $(uptime -p 2>/dev/null || echo "Unknown")"

if command_exists free; then
    echo
    free -h
fi

if command_exists df; then
    echo
    echo "Disk Usage:"
    df -h / 2>/dev/null | tail -n +2
fi

log_success "System audit completed"
