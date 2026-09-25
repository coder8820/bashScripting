#!/usr/bin/env bash

RISK_SCORE=0

reset_score() {
    RISK_SCORE=0
}

add_score() {
    local points="$1"
    RISK_SCORE=$((RISK_SCORE + points))
    (( RISK_SCORE > 100 )) && RISK_SCORE=100
}

risk_level() {
    if (( RISK_SCORE >= 81 )); then
        echo "CRITICAL"
    elif (( RISK_SCORE >= 51 )); then
        echo "HIGH"
    elif (( RISK_SCORE >= 21 )); then
        echo "MEDIUM"
    else
        echo "LOW"
    fi
}

print_risk_summary() {
    echo
    echo "=============================================="
    echo "              RISK SUMMARY"
    echo "=============================================="
    echo "Risk Score : ${RISK_SCORE}/100"
    echo "Risk Level : $(risk_level)"
}
