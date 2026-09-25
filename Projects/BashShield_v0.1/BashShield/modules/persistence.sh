#!/usr/bin/env bash
section "PERSISTENCE CHECK"

echo "User cron jobs:"
if command_exists crontab; then
    crontab -l 2>/dev/null || echo "  No user crontab or permission denied"
else
    echo "  crontab command unavailable"
fi

echo
echo "System cron directories:"
for dir in /etc/cron.d /etc/cron.daily /etc/cron.hourly /etc/cron.weekly /etc/cron.monthly; do
    if [[ -d "$dir" ]]; then
        count=$(find "$dir" -maxdepth 1 -type f 2>/dev/null | wc -l)
        echo "  $dir : $count file(s)"
    fi
done

echo
echo "SSH authorized_keys files:"
find /home /root -type f -name authorized_keys 2>/dev/null | while read -r file; do
    echo "  $file"
done

log_success "Persistence check completed"
