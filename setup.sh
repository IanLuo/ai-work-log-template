#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# 1. setup.sh
#    Creates a new work log file with given title
#    Usage: ./setup.sh "Ian-Work-Stream-2026"
# ------------------------------------------------------------------------------

if [ $# -ne 1 ]; then
    echo "Usage: $0 \"Your Log Title\""
    echo "Example: $0 \"Ian-Work-Stream-2026\""
    exit 1
fi

TITLE="$1"
FILENAME="${TITLE// /-}.md"           # replace spaces with dashes
TARGET_DIR="${HOME}/Documents/ai-work-log"
mkdir -p "$TARGET_DIR"

cd "$TARGET_DIR" || exit 1

if [ -f "$FILENAME" ]; then
    echo "File already exists: $FILENAME"
    echo "Aborting to prevent overwrite."
    exit 1
fi

cat > "$FILENAME" << 'EOF'
# ${TITLE}

## $(date +%Y-%m-%d) [ID:$(date +%Y%m%d)-init]

### Summary / Goal Today
First day of tracking

### Key Decisions & Rationales [#decision]
- Created new work log file with setup.sh

### Generated Data / Outputs [#data]
-

### Insights / Failures / Learnings [#insight #failure]
-

### Open Tasks / Next Actions [#task]
- Write first real entry

### References / Context Recall
- Initial setup
EOF

echo "Created new log file:"
echo "  $TARGET_DIR/$FILENAME"
echo ""
echo "You can now open it and start writing."
