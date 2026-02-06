#!/bin/bash
# validate-runbook.sh
#
# PostToolUse hook that triggers runbook validation after file creation.
# Fires after write_to_file or create_file tools are used.

# Read the tool input from stdin (JSON)
INPUT=$(cat)

# Extract the file path from the tool output
FILE_PATH=$(echo "$INPUT" | grep -oP '"filePath"\s*:\s*"\K[^"]+' 2>/dev/null || \
            echo "$INPUT" | grep -oP '"path"\s*:\s*"\K[^"]+' 2>/dev/null)

# Check if the file matches the runbook pattern
if [[ "$FILE_PATH" == *runbook-*.md ]]; then
  echo "📋 Runbook detected: $FILE_PATH"
  echo ""
  echo "Automatically validating against team standards..."
  echo "Please use the runbook-validator skill to check this file for compliance."
fi
