#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# 3. continue_last.sh
#    Shows the most recent entry + ready-to-paste header
# ------------------------------------------------------------------------------

LOG_DIR="${HOME}/Documents/ai-work-log"
DEFAULT_LOG="Ian-Work-Stream-2026.md"
LOG_FILE="$LOG_DIR/$DEFAULT_LOG"

if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found: $LOG_FILE"
    exit 1
fi

echo "# Ready to continue last work"
echo "# Paste the block below into your existing AI conversation"
echo ""

echo "Continuing from most recent entry:"
echo ""

# Extract the very last dated block (most recent)
awk '/^## [0-9]{4}-[0-9]{2}-[0-9]{2}/ {p=1} p' "$LOG_FILE" | tac | 
  awk '/^## [0-9]{4}-[0-9]{2}-[0-9]{2}/ {p=1; print; exit} p' | tac

echo ""
echo "# You can add after this:"
echo "#   New entry for today or continue discussion..."
echo ""
