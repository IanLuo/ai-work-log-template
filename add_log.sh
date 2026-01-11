#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# 5. add_log.sh
#    Quickly appends a NEW dated log block to your log file
#    Interactive: Prompts for each section (or use pipe/args for batch)
#    Usage:
#      ./add_log.sh                    # Interactive mode (recommended)
#      echo "My summary" | ./add_log.sh  # Pipe content
# ------------------------------------------------------------------------------

LOG_DIR="${HOME}/Documents/ai-work-log"
DEFAULT_LOG="Ian-Work-Stream-2026.md"
LOG_FILE="$LOG_DIR/$DEFAULT_LOG"

if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found: $LOG_FILE"
    echo "Run ./setup.sh first!"
    exit 1
fi

# Generate today's date/ID
TODAY=$(date +%Y-%m-%d)
ID=$(date +%Y%m%d)-$(date +%H%M)  # e.g., 20260111-1145

echo "=== Adding new entry to $LOG_FILE ==="
echo "Date: $TODAY [ID:$ID]"
echo ""

# Interactive prompts (can be overridden by piped input later)
read -r -p "Summary / Goal Today: " SUMMARY
read -r -p "Key Decisions (or 'none'): " DECISIONS
read -r -p "Generated Data/Outputs (or 'none'): " DATA
read -r -p "Insights/Failures (or 'none'): " INSIGHTS
read -r -p "Open Tasks/Next (or 'none'): " TASKS
read -r -p "References/Context (or 'none'): " REFS

# Build the new block
NEW_BLOCK=$(cat << EOF

## $TODAY [ID:$ID]

### Summary / Goal Today
$SUMMARY

### Key Decisions & Rationales [#decision]
$DECISIONS

### Generated Data / Outputs [#data]
$DATA

### Insights / Failures / Learnings [#insight #failure]
$INSIGHTS

### Open Tasks / Next Actions [#task]
$TASKS

### References / Context Recall
$REFS
EOF
)

# Append to file (newest at TOP — move existing content down)
{
  echo "$NEW_BLOCK"
  cat "$LOG_FILE"
} > "$LOG_FILE.tmp" && mv "$LOG_FILE.tmp" "$LOG_FILE"

echo ""
echo "✅ New entry added! [ID:$ID]"
echo "File updated: $LOG_FILE"
echo "Tip: Run ./continue_last.sh to paste into AI chat."
