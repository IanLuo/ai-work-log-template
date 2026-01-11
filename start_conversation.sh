#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# 2. start_conversation.sh
#    Prints the instruction template + most recent entries
#    (ready to be copied & pasted into a fresh AI conversation)
# ------------------------------------------------------------------------------

LOG_DIR="${HOME}/Documents/ai-work-log"
DEFAULT_LOG="Ian-Work-Stream-2026.md"

# You can change this or make it accept argument later
LOG_FILE="$LOG_DIR/$DEFAULT_LOG"

if [ ! -f "$LOG_FILE" ]; then
    echo "Log file not found: $LOG_FILE"
    echo "Please run setup.sh first or check the path."
    exit 1
fi

echo "# === PASTE EVERYTHING BELOW THIS LINE INTO A NEW AI CHAT === #"
echo ""
echo "# Paste this at the beginning of a fresh conversation"

cat << 'EOF'

You are now working with me on my personal projects. I want you to always maintain a persistent, structured work log exactly like this format — even across different chat sessions.

### CORE RULES – MUST FOLLOW EVERY TIME

1. Reverse-Chronological Append-Only Journal Style
   - Always add new entries at the very top (newest first)
   - Never edit or delete old entries — only append
   - Use Markdown format with clear headings

2. Every new block must start with:
   ## YYYY-MM-DD [ID:YYYYMMDD-unique-tag]

3. Mandatory sections (use even if empty):
   ### Summary / Goal Today
   ### Key Decisions & Rationales [#decision]
   ### Generated Data / Outputs [#data]
   ### Insights / Failures / Learnings [#insight #failure]
   ### Open Tasks / Next Actions [#task]
   ### References / Context Recall

4. Use these tags liberally: #decision #data #failure #insight #task

5. When I paste previous log entries, treat them as source of truth and continue from there.

Now please confirm you understand and will follow this system.

EOF

echo ""
echo "# === Recent context (last 10 entries or less) === #"
echo ""

# Show last 10 dated blocks (approximation)
tail -n 400 "$LOG_FILE" | 
  awk '/^## [0-9]{4}-[0-9]{2}-[0-9]{2}/ {p=1} p&&/^## /&&NR>1 {exit} p' |
  tac | head -n 200 | tac   # rough way to get recent blocks

echo ""
echo "# === END OF PASTE CONTENT === #"
echo "Copy everything between the === lines and paste into your AI chat."
