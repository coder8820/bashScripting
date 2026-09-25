#!/usr/bin/env bash
section "IOC SCAN"

BASE_DIR="${BASE_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
IOC_FILE="$BASE_DIR/config/iocs.txt"

if [[ ! -f "$IOC_FILE" ]]; then
    log_warn "IOC database not found: $IOC_FILE"
    exit 0
fi

echo "Configured IOCs:"
grep -vE '^\s*(#|$)' "$IOC_FILE" | sed 's/^/  /'

echo
echo "This first version performs a safe filename/path-oriented scan."
echo "Search locations: /tmp and /dev/shm"

MATCH=0
while read -r ioc; do
    [[ -z "$ioc" || "$ioc" == \#* ]] && continue

    for base in /tmp /dev/shm; do
        [[ -d "$base" ]] || continue
        if find "$base" -name "$(basename "$ioc")" -print -quit 2>/dev/null | grep -q .; then
            echo "[IOC MATCH] $ioc"
            MATCH=1
            add_score 40
        fi
    done
done < "$IOC_FILE"

(( MATCH == 0 )) && echo "[OK] No configured IOC filenames found in scan locations."

log_success "IOC scan completed"
