#!/usr/bin/env bash
section "PROCESS ANALYSIS"

if ! command_exists ps; then
    log_error "ps command not available"
    exit 0
fi

echo "Top processes by CPU:"
ps -eo pid,user,pcpu,pmem,comm --sort=-pcpu | head -n 11

echo
echo "Processes running from temporary locations:"
FOUND=0
while read -r pid user command; do
    [[ -z "$pid" ]] && continue
    exe="$(readlink -f "/proc/$pid/exe" 2>/dev/null || true)"
    if [[ "$exe" == /tmp/* || "$exe" == /dev/shm/* ]]; then
        echo "  [SUSPICIOUS] PID=$pid USER=$user EXE=$exe"
        FOUND=1
        add_score 25
    fi
done < <(ps -eo pid=,user=,comm=)

(( FOUND == 0 )) && echo "  No executable found in /tmp or /dev/shm."

log_success "Process analysis completed"
