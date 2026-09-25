#!/usr/bin/env bash
section "FILE INTEGRITY CHECK"

BASE_DIR="${BASE_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
CONFIG="$BASE_DIR/config/monitored_files.txt"
DATA_DIR="$BASE_DIR/data"
BASELINE="$DATA_DIR/baseline.db"

mkdir -p "$DATA_DIR"

if [[ ! -f "$CONFIG" ]]; then
    log_warn "No monitored_files.txt found"
    exit 0
fi

if [[ ! -f "$BASELINE" ]]; then
    echo "Baseline does not exist."
    echo "Create it with:"
    echo "  sha256sum <file> > data/baseline.db"
    echo
    echo "For safety, only readable files listed in config will be considered."
    exit 0
fi

while read -r file; do
    [[ -z "$file" || "$file" == \#* ]] && continue

    if [[ ! -e "$file" ]]; then
        echo "[MISSING] $file"
        add_score 30
        continue
    fi

    current=$(sha256sum "$file" 2>/dev/null | awk '{print $1}')
    old=$(awk -v f="$file" '$0 ~ "  " f "$" {print $1}' "$BASELINE")

    if [[ -z "$old" ]]; then
        echo "[NEW] $file (not present in baseline)"
    elif [[ "$current" == "$old" ]]; then
        echo "[OK] $file"
    else
        echo "[MODIFIED] $file"
        add_score 30
    fi
done < "$CONFIG"

log_success "Integrity check completed"
