#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# 1. setup.sh
#    Creates a new work log file with given title
#    Usage: ./setup.sh "Ian-Work-Stream-2026"
# ------------------------------------------------------------------------------

# Load shared config library
source "$(dirname "$0")/lib_config.sh"

if [ $# -ne 1 ]; then
    echo "Usage: $0 \"Your Log Title\""
    echo "Example: $0 \"Ian-Work-Stream-2026\""
    exit 1
fi

TITLE="$1"
FILENAME="${TITLE// /-}.md"           # replace spaces with dashes

# Get script directory
SCRIPT_DIR=$(get_script_dir "$0")
TARGET_DIR="$SCRIPT_DIR"

cd "$TARGET_DIR" || exit 1

if [ -f "$FILENAME" ]; then
    echo "File already exists: $FILENAME"
    echo "Aborting to prevent overwrite."
    exit 1
fi

# Create the log file
cat > "$FILENAME" <<EOF
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

# Create or update config file
LOG_NAME="${TITLE// /-}"  # filename without .md extension
CONFIG_FILE="$TARGET_DIR/config"

if [ -f "$CONFIG_FILE" ]; then
    # Update existing config
    if grep -q "^DEFAULT_LOG=" "$CONFIG_FILE"; then
        # Replace existing DEFAULT_LOG line
        sed -i.bak "s|^DEFAULT_LOG=.*|DEFAULT_LOG=\"$LOG_NAME\"|" "$CONFIG_FILE"
        rm -f "${CONFIG_FILE}.bak"
    else
        # Append DEFAULT_LOG
        echo "DEFAULT_LOG=\"$LOG_NAME\"" >> "$CONFIG_FILE"
    fi
    echo "Updated config file with DEFAULT_LOG=$LOG_NAME"
else
    # Create new config file
    cat > "$CONFIG_FILE" <<EOF
# AI Work Log Configuration
# Default log file name (without .md extension)
DEFAULT_LOG="$LOG_NAME"
EOF
    echo "Created config file with DEFAULT_LOG=$LOG_NAME"
fi

echo ""
echo "Created new log file:"
echo "  $TARGET_DIR/$FILENAME"
echo ""
echo "You can now open it and start writing."
