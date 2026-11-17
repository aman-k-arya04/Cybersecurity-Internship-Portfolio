
#!/bin/bash

# ==========================================
# PROJECT 04: LINUX LOG ANALYZER
# ==========================================

AUTH_LOG="/var/log/auth.log"
SYS_LOG="/var/log/syslog"

echo "=========================================="
echo "          LINUX LOG ANALYZER"
echo "=========================================="

# 1. Check authentication logs
echo ""
echo "[1] FAILED LOGIN ATTEMPTS"

if [[ -r "$AUTH_LOG" ]]; then

    FAILED_COUNT=$(grep -Eic 'Failed password|authentication failure' "$AUTH_LOG" || true)

    echo "Log source: $AUTH_LOG"
    echo "Failed login entries: $FAILED_COUNT"

    echo ""
    echo "Recent failed login entries:"
    grep -Ei 'Failed password|authentication failure' "$AUTH_LOG" | tail -n 10 || true

elif command -v journalctl >/dev/null 2>&1; then

    FAILED_COUNT=$(journalctl --no-pager -o cat 2>/dev/null | grep -Eic 'Failed password|authentication failure' || true)

    echo "Log source: system journal"
    echo "Failed login entries: $FAILED_COUNT"

else
    echo "Authentication logs are unavailable."
fi

# 2. Check invalid username attempts
echo ""
echo "[2] INVALID USER ATTEMPTS"

if [[ -r "$AUTH_LOG" ]]; then

    INVALID_COUNT=$(grep -Eic 'Invalid user' "$AUTH_LOG" || true)

    echo "Invalid username entries: $INVALID_COUNT"

elif command -v journalctl >/dev/null 2>&1; then

    INVALID_COUNT=$(journalctl --no-pager -o cat 2>/dev/null | grep -Eic 'Invalid user' || true)

     echo "Log source:system journal" 
     echo "Invalid username entries: $INVALID_COUNT"

else
    echo "Authentication logs are unavailable."
fi

# 3. Check system errors
echo ""
echo "[3] SYSTEM ERROR ANALYSIS"

if [[ -r "$SYS_LOG" ]]; then

    ERROR_COUNT=$(grep -Eic '(^|[[:space:]])(error|err|critical|alert|emerg)(:|[[:space:]]|$)' "$SYS_LOG" || true)

    echo "Log source: $SYS_LOG"
    echo "System error entries: $ERROR_COUNT"

elif command -v journalctl >/dev/null 2>&1; then

    ERROR_COUNT=$(journalctl -p err --no-pager -q 2>/dev/null | awk 'END {print NR}')

    echo "Log source: system journal"
    echo "System error entries: $ERROR_COUNT"

else
    echo "System error logs are unavailable."
fi

# 4. Final report
echo ""
echo "=========================================="
echo "          ANALYSIS COMPLETE"
echo "=========================================="
