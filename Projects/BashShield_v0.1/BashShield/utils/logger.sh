#!/usr/bin/env bash
BASE_DIR="${BASE_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
LOG_DIR="$BASE_DIR/logs"
LOG_FILE="$LOG_DIR/bashshield.log"

mkdir -p "$LOG_DIR"

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
    printf '%s [INFO] %s\n' "$(date '+%F %T')" "$1" >> "$LOG_FILE"
}

log_success() {
    echo -e "${GREEN}[OK]${NC} $1"
    printf '%s [OK] %s\n' "$(date '+%F %T')" "$1" >> "$LOG_FILE"
}

log_warn() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
    printf '%s [WARNING] %s\n' "$(date '+%F %T')" "$1" >> "$LOG_FILE"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
    printf '%s [ERROR] %s\n' "$(date '+%F %T')" "$1" >> "$LOG_FILE"
}
