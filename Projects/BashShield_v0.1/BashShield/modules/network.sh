#!/usr/bin/env bash
section "NETWORK AUDIT"

if command_exists ss; then
    echo "Listening TCP/UDP sockets:"
    ss -tuln
    echo
    echo "Established connections:"
    ss -tun state established
elif command_exists netstat; then
    netstat -tuln
else
    log_warn "Neither ss nor netstat is available"
fi

if command_exists ip; then
    echo
    echo "Network interfaces:"
    ip -brief addr
fi

log_success "Network audit completed"
