#!/bin/sh
# install-git-hooks.sh
# This script copies Git hooks from the project_hooks directory to the .git/hooks directory
# and makes them executable.

# The directory in your project where your custom hooks are stored
SOURCE_HOOKS_DIR="hooks"

# The Git hooks directory
GIT_HOOKS_DIR=".git/hooks"

# Check if the source hooks directory exists
if [ ! -d "$SOURCE_HOOKS_DIR" ]; then
  echo "Source hooks directory '$SOURCE_HOOKS_DIR' not found." 
  echo "Please create it and add your hook files there."
  exit 1
fi

# Check if .git/hooks directory exists (it should in a Git repository)
if [ ! -d "$GIT_HOOKS_DIR" ]; then
  echo "Git hooks directory '$GIT_HOOKS_DIR' not found." 
  echo "Are you sure this is a Git repository?"
  exit 1
fi

echo "Installing Git hooks from '$SOURCE_HOOKS_DIR' to '$GIT_HOOKS_DIR'..."

# Iterate over each file in the source hooks directory
for hook_file in "$SOURCE_HOOKS_DIR"/*; do
  if [ -f "$hook_file" ]; then
    base_name=$(basename "$hook_file")
    destination_hook="$GIT_HOOKS_DIR/$base_name"
    
    echo "  Copying $base_name to $GIT_HOOKS_DIR/..."
    cp "$hook_file" "$destination_hook"
    
    echo "  Making $base_name executable..."
    chmod +x "$destination_hook"
    
    echo "  Hook $base_name installed successfully."
  fi
done

echo "All hooks installed." 