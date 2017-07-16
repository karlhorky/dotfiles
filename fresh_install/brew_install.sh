#!/usr/bin/env bash

main() {
  info "Installing Homebrew formulae..."

  if [[ $(cmd_exists "brew") -eq 1 ]]; then
    error "Homebrew not installed!"
    exit 1
  fi

  local i=""
  local formula=""
  local -a formulae=(
    "vim"
    "git"
    "hub"
    "node"
    "yarn"
  )

  for i in ${!formulae[*]}; do
    formula="${formulae[$i]}"
    [ $(brew list "$formula" &> /dev/null; printf $?) -eq 0 ] \
      && success "$formula" \
      || execute "brew install $formula" "brew install $formula"
  done

  # Install vim packages
  mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim  # pathogen.vim: runtime path manager for easy plugin installation https://github.com/tpope/vim-pathogen
  cd ~/.vim/bundle
  git clone git://github.com/tpope/vim-sleuth.git  # sleuth.vim: automatically detect buffer indentation settings and configure based on that https://github.com/tpope/vim-sleuth

  execute "brew cask install google-chrome" "brew cask install google-chrome"
  execute "brew cask install firefox" "brew cask install firefox"
  execute "brew cask install hyper" "brew cask install hyper"
  execute "brew cask install slack" "brew cask install slack"
  execute "brew cask install discord" "brew cask install discord"
  execute "brew cask install caprine" "brew cask install caprine"
  execute "brew cask install whatsapp" "brew cask install whatsapp"
  execute "brew cask install skype" "brew cask install skype"
  execute "brew cask install keybase" "brew cask install keybase"
  execute "brew cask install magicprefs" "brew cask install magicprefs"
  execute "brew cask install yujitach-menumeters" "brew cask install yujitach-menumeters"
  # Install Flycut clipboard manager
  execute "brew cask install flycut" "brew cask install flycut"
  # Install KeepingYouAwake - Prevent your Mac from sleeping
  execute "brew cask install keepingyouawake" "brew cask install keepingyouawake"
  # Install ngrok: Secure introspectable tunnels to localhost
  execute "brew cask install ngrok" "brew cask install ngrok"
  # Install Arq Backup
  execute "brew cask install arq" "brew cask install arq"
  # Install QLStephen plain text file Quick Look plugin
  execute "brew cask install qlstephen" "brew cask install qlstephen"
  # Install WebP Quick Look plugin
  execute "brew cask install webpquicklook" "brew cask install webpquicklook"

  # Add drivers tap and install SteelSeries ExactMouse to disable macOS mouse acceleration
  execute "brew tap caskroom/drivers" "brew tap caskroom/drivers"
  execute "brew cask install steelseries-exactmouse-tool" "brew cask install steelseries-exactmouse-tool"

  # Install Atom and packages
  execute "brew cask install atom" "brew cask install atom"
  execute "apm install atom-alignment" "apm install atom-alignment"
  execute "apm install atom-no-tab-close-button" "apm install atom-no-tab-close-button"
  execute "apm install busy-signal" "apm install busy-signal"
  execute "apm install easy-motion-redux" "apm install easy-motion-redux"
  execute "apm install editorconfig" "apm install editorconfig"
  execute "apm install highlight-line" "apm install highlight-line"
  execute "apm install intentions" "apm install intentions"
  execute "apm install language-groovy" "apm install language-groovy"
  execute "apm install language-reason" "apm install language-reason"
  execute "apm install layout-control" "apm install layout-control"
  execute "apm install linter" "apm install linter"
  execute "apm install linter-eslint" "apm install linter-eslint"
  execute "apm install linter-flow" "apm install linter-flow"
  execute "apm install linter-ui-default" "apm install linter-ui-default"
  execute "apm install prettier-atom" "apm install prettier-atom"
  execute "apm install save-session" "apm install save-session"
  execute "apm install sort-lines" "apm install sort-lines"
  execute "apm install typescript" "apm install typescript"
  execute "apm install vim-mode-plus" "apm install vim-mode-plus"

  # Install Sublime Text editor as alternative / backup to Atom
  execute "brew cask install sublime-text" "brew cask install sublime-text"

  # Install beta versions of casks
  execute "brew tap caskroom/versions" "brew tap caskroom/versions"
  execute "brew cask install gpgtools-beta" "brew cask install gpgtools-beta"

  # Install VeraCrypt and OSXFuse dependency
  execute "brew cask install osxfuse" "brew cask install osxfuse"
  execute "brew cask install veracrypt" "brew cask install veracrypt"

  # Install Mac App Store software
  execute "brew install mas" "brew install mas"
  execute "mas install 1176895641" "mas install 1176895641" # Spark - Love your email again

  success "Homebrew formulae installed!"
}

main
