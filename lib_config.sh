#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# lib_config.sh
# Shared configuration and utilities for all work log scripts
# Source this file in other scripts: source "$(dirname "$0")/lib_config.sh"
# ------------------------------------------------------------------------------

# Get script directory (resolves symlinks)
get_script_dir() {
    echo "$(cd "$(dirname "$1")" && pwd -P)"
}

# Load configuration
load_config() {
    local script_dir="$1"
    local config_file="$script_dir/config"
    
    # Set default
    DEFAULT_LOG=""
    
    # Load config if exists
    if [ -f "$config_file" ]; then
        while IFS='=' read -r key value; do
            # Skip comments and empty lines
            [[ "$key" =~ ^#.*$ ]] && continue
            [[ -z "$key" ]] && continue
            
            # Remove leading/trailing whitespace and quotes
            key=$(echo "$key" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
            value=$(echo "$value" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e 's/^"//' -e 's/"$//')
            
            if [ "$key" = "DEFAULT_LOG" ]; then
                DEFAULT_LOG="$value"
            fi
        done < "$config_file"
    fi
}

# Select log file (auto-detect or prompt)
select_log_file() {
    local script_dir="$1"
    local log_dir="$script_dir"
    
    # Find all .md files except templates and examples
    local log_files=()
    while IFS= read -r file; do
        local basename=$(basename "$file")
        # Skip template files and files starting with dot
        if [[ ! "$basename" =~ TEMPLATE\.md$ ]] && [[ ! "$basename" =~ ^\..*\.md$ ]]; then
            log_files+=("$basename")
        fi
    done < <(find "$log_dir" -maxdepth 1 -name "*.md" -type f 2>/dev/null)
    
    # If DEFAULT_LOG is set and exists, use it
    if [ -n "$DEFAULT_LOG" ]; then
        local default_file="${DEFAULT_LOG}.md"
        if [ -f "$log_dir/$default_file" ]; then
            echo "$log_dir/$default_file"
            return 0
        fi
    fi
    
    # If only one log file exists, use it
    if [ ${#log_files[@]} -eq 1 ]; then
        echo "$log_dir/${log_files[0]}"
        return 0
    fi
    
    # If no log files, return empty
    if [ ${#log_files[@]} -eq 0 ]; then
        echo ""
        return 1
    fi
    
    # Multiple files: prompt user to select
    echo "Multiple log files found:" >&2
    for i in "${!log_files[@]}"; do
        echo "  $((i+1)). ${log_files[$i]}" >&2
    done
    
    while true; do
        read -r -p "Select log file (1-${#log_files[@]}): " selection
        if [[ "$selection" =~ ^[0-9]+$ ]] && [ "$selection" -ge 1 ] && [ "$selection" -le ${#log_files[@]} ]; then
            echo "$log_dir/${log_files[$((selection-1))]}"
            return 0
        fi
        echo "Invalid selection. Please enter a number between 1 and ${#log_files[@]}." >&2
    done
}
