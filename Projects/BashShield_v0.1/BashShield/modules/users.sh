#!/usr/bin/env bash
section "USER & ACCOUNT AUDIT"

if [[ ! -r /etc/passwd ]]; then
    log_warn "Cannot read /etc/passwd"
    exit 0
fi

echo "UID 0 accounts:"
awk -F: '$3 == 0 {print "  " $1}' /etc/passwd

echo
echo "Interactive/login-shell accounts:"
awk -F: '$7 !~ /(nologin|false)$/ {print "  " $1 " -> " $7}' /etc/passwd

if [[ -r /etc/shadow ]]; then
    echo
    echo "Accounts without a password:"
    awk -F: '($2 == "" || $2 == "!") {print "  " $1}' /etc/shadow
else
    log_warn "/etc/shadow is not readable; password checks skipped"
fi

log_success "User audit completed"
