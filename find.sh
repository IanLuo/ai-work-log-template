#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# 4. find.sh
#    Simple full-text search in the log file
#    Usage examples:
#      ./find.sh echodeck
#      ./find.sh "#decision"
#      ./find.sh "2026-01-10"
# ------------------------------------------------------------------------------

# Load shared config library
source "$(dirname "$0")/lib_config.sh"

if [ $# -eq 0 ]; then
    echo "Usage: $0 \"search term\""
    echo "Examples:"
    echo "  $0 echodeck"
    echo "  $0 \"#decision\""
    echo "  $0 \"2026-01-10\""
    exit 1
fi

SCRIPT_DIR=$(get_script_dir "$0")
load_config "$SCRIPT_DIR"
LOG_FILE=$(select_log_file "$SCRIPT_DIR")

if [ -z "$LOG_FILE" ] || [ ! -f "$LOG_FILE" ]; then
    echo "No log file found. Run ./setup.sh first!"
    exit 1
fi

echo "Searching for: $@"
echo "----------------------------------------"
grep -i -C 8 --color=always "$*" "$LOG_FILE" || echo "No matches found."
echo "----------------------------------------"
echo "Tip: Use quotes for phrases, # for tags, dates for sections"
