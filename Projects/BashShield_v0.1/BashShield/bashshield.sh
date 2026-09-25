#!/usr/bin/env bash
set -u

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$BASE_DIR/utils/colors.sh"
source "$BASE_DIR/utils/logger.sh"
source "$BASE_DIR/utils/helpers.sh"
source "$BASE_DIR/utils/scoring.sh"

MODULE_DIR="$BASE_DIR/modules"
REPORT_DIR="$BASE_DIR/reports"

usage() {
    cat <<EOF
BashShield - Linux Security Audit & Incident Response Toolkit

Usage:
  ./bashshield.sh audit          Run system audit
  ./bashshield.sh users          Audit user accounts
  ./bashshield.sh processes      Analyze running processes
  ./bashshield.sh network        Audit network state
  ./bashshield.sh logs           Analyze authentication logs
  ./bashshield.sh persistence    Check persistence mechanisms
  ./bashshield.sh integrity      Check monitored file integrity
  ./bashshield.sh ioc             Scan configured IOCs
  ./bashshield.sh scan            Run all available checks
  ./bashshield.sh report         Show latest report
  ./bashshield.sh help           Show this help
EOF
}

run_module() {
    local module="$1"
    local script="$MODULE_DIR/${module}.sh"

    if [[ ! -f "$script" ]]; then
        log_error "Module not found: $module"
        return 1
    fi

    bash "$script"
}

case "${1:-help}" in
    audit)       run_module system ;;
    users)       run_module users ;;
    processes)   run_module processes ;;
    network)     run_module network ;;
    logs)        run_module logs ;;
    persistence) run_module persistence ;;
    integrity)   run_module integrity ;;
    ioc)         run_module ioc ;;
    scan)
        print_banner
        reset_score
        run_module system
        run_module users
        run_module processes
        run_module network
        run_module logs
        run_module persistence
        run_module integrity
        run_module ioc
        print_risk_summary
        ;;
    report)
        latest_report "$REPORT_DIR"
        ;;
    help|*)
        print_banner
        usage
        ;;
esac
