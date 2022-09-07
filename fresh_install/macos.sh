#!/usr/bin/env bash

info "Configuring macOS System settings..."
info "Manual step: macOS: System Preferences > Accessibility > Display > Reduce Motion"

# Disable press-and-hold for keys in favor of key repeat
sudo defaults write -g ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
sudo defaults write NSGlobalDomain KeyRepeat -int 1
sudo defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Increase window resize speed for Cocoa applications
# Affects showing and hiding sheets, resizing preference windows, zooming windows
# float 0 doesn't work
sudo defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Finder: disable window animations and Get Info animations
sudo defaults write com.apple.finder DisableAllAnimations -bool true

# Check for software updates daily, not just once per week
sudo defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Disable system-wide resume? (y/n)
sudo defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Enable full keyboard access for all controls (enable tab in modal dialogs, menu windows, etc.)
sudo defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable auto-correct
sudo defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable auto capitalize
sudo defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable auto period insert
sudo defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Require password immediately after sleep or screen saver begins
sudo defaults write com.apple.screensaver askForPassword -int 1
sudo defaults write com.apple.screensaver askForPasswordDelay -int 0

# Use column view in all Finder windows by default
sudo defaults write com.apple.finder FXPreferredViewStyle Clmv

# Allow text selection in Quick Look in Finder
sudo defaults write com.apple.finder QLEnableTextSelection -bool true

# Don't send Safari search queries to Apple
sudo defaults write com.apple.Safari UniversalSearchEnabled -bool false
sudo defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Set the text on the login screen in case computer lost
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "If lost please contact Karl at <email address>"

# Disable mouse acceleration
# Ref: https://apple.stackexchange.com/questions/333989/how-do-i-disable-mouse-acceleration-and-adjust-tracking-speed-in-high-sierra
sudo defaults write .GlobalPreferences com.apple.mouse.scaling -1

# Change indexing order and disable some search results
# Yosemite-specific search results (remove them if your are using OS X 10.9 or older):
# 	MENU_DEFINITION            Dictionary definitions
# 	MENU_CONVERSION            Unit conversion
# 	MENU_EXPRESSION            Calculator
# 	MENU_SPOTLIGHT_SUGGESTIONS (send search queries to Apple)
# 	MENU_WEBSEARCH             (send search queries to Apple)
# 	MENU_OTHER
sudo defaults write com.apple.spotlight orderedItems -array \
	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
	'{"enabled" = 1;"name" = "DIRECTORIES";}' \
	'{"enabled" = 1;"name" = "PDF";}' \
	'{"enabled" = 1;"name" = "FONTS";}' \
	'{"enabled" = 0;"name" = "DOCUMENTS";}' \
	'{"enabled" = 0;"name" = "MESSAGES";}' \
	'{"enabled" = 0;"name" = "CONTACT";}' \
	'{"enabled" = 0;"name" = "EVENT_TODO";}' \
	'{"enabled" = 0;"name" = "IMAGES";}' \
	'{"enabled" = 0;"name" = "BOOKMARKS";}' \
	'{"enabled" = 0;"name" = "MUSIC";}' \
	'{"enabled" = 0;"name" = "MOVIES";}' \
	'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
	'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
	'{"enabled" = 0;"name" = "SOURCE";}' \
	'{"enabled" = 1;"name" = "MENU_DEFINITION";}' \
	'{"enabled" = 0;"name" = "MENU_OTHER";}' \
	'{"enabled" = 1;"name" = "MENU_CONVERSION";}' \
	'{"enabled" = 1;"name" = "MENU_EXPRESSION";}' \
	'{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
	'{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'

# Save screenshots to the Downloads folder
sudo defaults write com.apple.screencapture location -string "${HOME}/Downloads"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Kill all dock processes to apply changes
killall Dock

# Set your computer name to avoid random changes
# when you're connected to public wifi networks.
#
# Otherwise, your hostname that appears when you
# run `hostname` may change to the name of the
# DNS or DHCP server 🤯
#
# Source: https://apple.stackexchange.com/a/127405/36202
sudo scutil --set HostName 'Karls-MacBook-Pro.local'

success "macOS System settings configured\n"
