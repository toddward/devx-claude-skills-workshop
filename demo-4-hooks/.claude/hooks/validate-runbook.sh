#!/bin/bash
# validate-runbook.sh
# 
# This hook fires after Claude writes or creates a file.
# It checks if the file is a runbook and triggers validation.
#
# TODO: Implement the hook logic
# 
# The hook receives context via environment variables:
#   $TOOL_NAME - The tool that was used (e.g., "write_to_file", "create_file")  
#   $FILE_PATH - The path of the file that was created/modified
#
# Your task:
# 1. Check if the file matches the runbook pattern (runbook-*.md)
# 2. If it does, output a message that triggers validation
# 3. If it doesn't, exit silently

# Example structure:
# if [[ "$FILE_PATH" == *runbook-*.md ]]; then
#   echo "Runbook detected: $FILE_PATH"
#   echo "Please validate this runbook against team standards using the runbook-validator skill."
# fi
