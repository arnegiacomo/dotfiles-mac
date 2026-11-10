#!/usr/bin/env bash
# macOS settings that differ from the system defaults. Dark mode applies after logging out.
set -euo pipefail

# Dock: hidden, on the left, no recent apps
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock orientation -string left
defaults write com.apple.dock show-recents -bool false

# Finder: list view, path bar, all file extensions, new windows open the home folder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder FXPreferredViewStyle -string Nlsv
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder NewWindowTarget -string PfHm

defaults write NSGlobalDomain AppleInterfaceStyle -string Dark

# Clicking the wallpaper doesn't hide windows; tiled windows have no gaps
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false

# VS Code: holding a key repeats it (for vim motions) instead of showing the accent popup
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

killall Dock Finder
