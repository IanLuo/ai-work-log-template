#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# 4. find.sh
#    Simple full-text search in the log file
#    Usage examples:
#      ./find.sh echodeck
#      ./find.sh "#decision"
#      ./find.sh "2026-01-10"
# ------------------------------------------------------------------------------

LOG_DIR="${HOME}/Documents/ai-work-log"
DEFAULT_LOG="Ian-Work-Stream-2026.md"
LOG_FILE="$LOG_DIR/$DEFAULT_LOG"

if [ $# -eq 0 ]; then
    echo "Usage: $0 \"search term\""
    echo "Examples:"
    echo "  $0 echodeck"
    echo "  $0 \"#decision\""
    echo "  $0 \"2026-01-10\""
    exit 1
fi

if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found: $LOG_FILE"
    exit 1
fi

echo "Searching for: $@"
echo "----------------------------------------"
grep -i -C 8 --color=always "$*" "$LOG_FILE" || echo "No matches found."
echo "----------------------------------------"
echo "Tip: Use quotes for phrases, # for tags, dates for sections"
