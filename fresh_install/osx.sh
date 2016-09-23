#!/usr/bin/env bash

info "Configuring macOS System settings..."

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Increase window resize speed for Cocoa applications
# Affects showing and hiding sheets, resizing preference windows, zooming windows
# float 0 doesn't work
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Finder: disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Disable system-wide resume? (y/n)
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Enable full keyboard access for all controls (enable tab in modal dialogs, menu windows, etc.)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Use column view in all Finder windows by default
defaults write com.apple.finder FXPreferredViewStyle Clmv

# Allow text selection in Quick Look in Finder
defaults write com.apple.finder QLEnableTextSelection -bool true

# Don't send Safari search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Change indexing order and disable some search results
# Yosemite-specific search results (remove them if your are using OS X 10.9 or older):
# 	MENU_DEFINITION            Dictionary definitions
# 	MENU_CONVERSION            Unit conversion
# 	MENU_EXPRESSION            Calculator
# 	MENU_SPOTLIGHT_SUGGESTIONS (send search queries to Apple)
# 	MENU_WEBSEARCH             (send search queries to Apple)
# 	MENU_OTHER
defaults write com.apple.spotlight orderedItems -array \
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

success "OS X System settings configured\n"

