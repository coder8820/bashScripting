#!/usr/bin/env bash

section() {
    echo
    echo "========== $1 =========="
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

require_command() {
    if ! command_exists "$1"; then
        log_warn "Required command not available: $1"
        return 1
    fi
    return 0
}
