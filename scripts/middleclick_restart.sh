#!/bin/bash

# MiddleClick Restart Setup Script
#
# Configure a launch agent to auto-restart MiddleClick every 4 hours
# - https://github.com/artginzburg/MiddleClick/issues/77#issuecomment-2957244017

set -e # Exit on any error

# Get the current user
CURRENT_USER=$(whoami)
USER_HOME=$(eval echo ~$CURRENT_USER)

# Define paths
SCRIPT_DIR="$USER_HOME/.local/scripts/middleclick_restart"
PLIST_FILE="$SCRIPT_DIR/com.$CURRENT_USER.middleclick_restart.plist"
SCRIPT_FILE="$SCRIPT_DIR/middleclick_restart.sh"
LOG_FILE="$SCRIPT_DIR/middleclick_restart.log"
LAUNCHAGENTS_DIR="$USER_HOME/Library/LaunchAgents"
LAUNCHAGENTS_PLIST="$LAUNCHAGENTS_DIR/com.$CURRENT_USER.middleclick_restart.plist"

echo "Setting up MiddleClick restart automation for user: $CURRENT_USER"
echo "Script directory: $SCRIPT_DIR"

# Create the script directory if it doesn't exist
echo "Creating directory structure..."
mkdir -p "$SCRIPT_DIR"
mkdir -p "$LAUNCHAGENTS_DIR"

# Create the plist file
echo "Creating LaunchAgent plist file..."
cat >"$PLIST_FILE" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>Label</key>
        <string>com.$CURRENT_USER.middleclick_restart</string>
        <key>ProgramArguments</key>
        <array>
            <string>$SCRIPT_FILE</string>
        </array>
        <key>StartInterval</key>
        <integer>14400</integer>
    </dict>
</plist>
EOF

# Create the restart script
echo "Creating restart script..."
cat >"$SCRIPT_FILE" <<'EOF'
#!/bin/bash

LOG_PATH="$SCRIPT_DIR/middleclick_restart.log"

killall MiddleClick 2>/dev/null || true
sleep 1
open -a MiddleClick
echo "Restarted at $(date +%Y-%m-%dT%H:%M:%S%Z)" >>"$LOG_PATH"

# Keep only the last 20 lines of the log (requires moreutils package with sponge)
if command -v sponge >/dev/null 2>&1; then
    tail -20 "$LOG_PATH" | sponge "$LOG_PATH"
else
    # Fallback if sponge is not available
    temp_file=$(mktemp)
    tail -20 "$LOG_PATH" > "$temp_file" && mv "$temp_file" "$LOG_PATH"
fi
EOF

# Replace the LOG_PATH placeholder in the script with the actual path
sed -i '' "s|\$SCRIPT_DIR|$SCRIPT_DIR|g" "$SCRIPT_FILE"

# Make the script executable
chmod +x "$SCRIPT_FILE"

# Create initial log file
touch "$LOG_FILE"

# Remove existing symlink if it exists
if [ -L "$LAUNCHAGENTS_PLIST" ]; then
  echo "Removing existing symlink..."
  rm "$LAUNCHAGENTS_PLIST"
fi

# Create symlink to LaunchAgents directory
echo "Creating symlink to LaunchAgents..."
ln -s "$PLIST_FILE" "$LAUNCHAGENTS_PLIST"

# Unload any existing job (ignore errors if it doesn't exist)
launchctl unload -w "$LAUNCHAGENTS_PLIST" 2>/dev/null || true

# Load the new job
echo "Loading LaunchAgent..."
launchctl load -w "$LAUNCHAGENTS_PLIST"

echo ""
echo "✅ Setup complete!"
echo ""
echo "Files created:"
echo "  - Plist file: $PLIST_FILE"
echo "  - Script file: $SCRIPT_FILE"
echo "  - Log file: $LOG_FILE"
echo "  - Symlink: $LAUNCHAGENTS_PLIST"
echo ""
echo "The MiddleClick application will now restart every 4 hours (14400 seconds)."
echo ""
echo "To check the status of the job:"
echo "  launchctl list | grep middleclick_restart"
echo ""
echo "To view the log:"
echo "  cat $LOG_FILE"
echo ""
echo "To manually unload the job:"
echo "  launchctl unload -w $LAUNCHAGENTS_PLIST"
echo ""
echo "To manually load the job:"
echo "  launchctl load -w $LAUNCHAGENTS_PLIST"

# Check if sponge is available and provide installation instructions if not
if ! command -v sponge >/dev/null 2>&1; then
  echo ""
  echo "⚠️  Note: The 'sponge' command is not available on your system."
  echo "   The script will use a fallback method for log rotation."
  echo "   To install sponge (part of moreutils), run:"
  echo "   brew install moreutils"
fi
