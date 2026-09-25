#!/usr/bin/env bash
section "AUTHENTICATION LOG ANALYSIS"

FAILED=0

if [[ -r /var/log/auth.log ]]; then
    FAILED=$(grep -cEi 'failed password|authentication failure' /var/log/auth.log 2>/dev/null || true)
elif [[ -r /var/log/secure ]]; then
    FAILED=$(grep -cEi 'failed password|authentication failure' /var/log/secure 2>/dev/null || true)
elif command_exists journalctl; then
    FAILED=$(journalctl --no-pager 2>/dev/null | grep -ciE 'failed password|authentication failure' || true)
else
    log_warn "No readable authentication log source found"
    exit 0
fi

echo "Failed authentication events: $FAILED"

if (( FAILED >= 20 )); then
    log_warn "High number of failed authentication events detected"
    add_score 20
elif (( FAILED >= 10 )); then
    log_warn "Repeated failed authentication events detected"
    add_score 10
else
    log_success "No high-volume authentication failure pattern detected"
fi

log_success "Log analysis completed"
