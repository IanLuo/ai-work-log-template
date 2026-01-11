#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# 3. continue_last.sh
#    Shows the most recent entry + ready-to-paste header
# ------------------------------------------------------------------------------

# Load shared config library
source "$(dirname "$0")/lib_config.sh"

SCRIPT_DIR=$(get_script_dir "$0")
load_config "$SCRIPT_DIR"
LOG_FILE=$(select_log_file "$SCRIPT_DIR")

if [ -z "$LOG_FILE" ] || [ ! -f "$LOG_FILE" ]; then
    echo "No log file found. Run ./setup.sh first!"
    exit 1
fi

echo "# Ready to continue last work"
echo "# Paste the block below into your existing AI conversation"
echo ""

echo "Continuing from most recent entry:"
echo ""

# Extract the very last dated block (most recent)
# Works on macOS (no tac command) by using tail -r
awk '/^## [0-9]{4}-[0-9]{2}-[0-9]{2}/ {p=1} p' "$LOG_FILE" | tail -r | 
  awk '/^## [0-9]{4}-[0-9]{2}-[0-9]{2}/ {p=1; print; next} p {print; exit}' | tail -r

echo ""
echo "# You can add after this:"
echo "#   New entry for today or continue discussion..."
echo ""
