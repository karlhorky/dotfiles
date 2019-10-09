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
    "git-lfs"
    "hub"
    "node"
    "yarn"
    "zsh"
    "zsh-completions"
    # Best PNG optimizer https://goo.gl/WCWW3D
    "pngquant"
  )

  for i in ${!formulae[*]}; do
    formula="${formulae[$i]}"
    [ $(brew list "$formula" &> /dev/null; printf $?) -eq 0 ] \
      && success "$formula" \
      || execute "brew install $formula" "brew install $formula"
  done

  # Install diff-highlight module and set it as default pager
  make -C $(brew --prefix git)/share/git-core/contrib/diff-highlight
  ln -sf "$(brew --prefix git)/share/git-core/contrib/diff-highlight/diff-highlight" /usr/local/bin/diff-highlight

  # Install vim packages
  mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim  # pathogen.vim: runtime path manager for easy plugin installation https://github.com/tpope/vim-pathogen
  cd ~/.vim/bundle
  git clone git://github.com/tpope/vim-sleuth.git  # sleuth.vim: automatically detect buffer indentation settings and configure based on that https://github.com/tpope/vim-sleuth

  # Google Chrome Browser and extensions
  execute "brew cask install google-chrome" "brew cask install google-chrome"
  # Only install untrusted extensions with limited permissions (not "Read and change all your data on the websites that you visit")
  # For extensions you want that need lots of permissions, review the code and save it to this repo,
  # such as utmstrip.user.js and javascript-errors-notifier/
  # TODO: Make list of used extensions here

  # Firefox browser
  execute "brew cask install firefox" "brew cask install firefox"
  # Safari Technical Preview browser
  execute "brew cask install safari-technology-preview" "brew cask install safari-technology-preview"
  execute "brew cask install hyper" "brew cask install hyper"
  execute "brew cask install slack" "brew cask install slack"
  execute "brew cask install discord" "brew cask install discord"
  # execute "brew cask install caprine" "brew cask install caprine"
  execute "brew cask install whatsapp" "brew cask install whatsapp"
  execute "brew cask install skype" "brew cask install skype"
  execute "brew cask install keybase" "brew cask install keybase"
  # Currently disabled because version 2.4.3 causes Inertia Scrolling (aka Momentum Scrolling) to fail in macOS 10.15 Catalina
  # execute "brew cask install magicprefs" "brew cask install magicprefs"
  # Currently disabled because of mis-clicks
  # execute "brew cask install dafuqtor/tap/midclick" "brew cask install dafuqtor/tap/midclick"
  # # Open MiddleClick in order to *manually* do the following:
  # # 1. Accept the Accessibility settings
  # # 2. Set the setting to "3 Finger Click"
  # open -a MiddleClick
  # # This sets the number of fingers to 2
  # defaults write com.rouge41.middleClick fingers 2
  execute "brew cask install yujitach-menumeters" "brew cask install yujitach-menumeters"
  # Install Disk Inventory X (disk space usage utility)
  execute "brew cask install disk-inventory-x" "brew cask install disk-inventory-x"
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
  # Install iterm2 Terminal Emulator
  execute "brew cask install iterm2" "brew cask install iterm2"
  # Install Adobe Acrobat Reader DC
  execute "brew cask install adobe-acrobat-reader" "brew cask install adobe-acrobat-reader"
  # Install Kap screen capture app (also exports to gif)
  execute "brew cask install kap" "brew cask install kap"
  # Install Google Music Manager
  execute "brew cask install music-manager" "brew cask install music-manager"
  # Install KeyboardCleanTool
  execute "brew cask install keyboardcleantool" "brew cask install keyboardcleantool"
  # Install KeePassXC Password Manager
  execute "brew cask install keepassxc" "brew cask install keepassxc"

  # Add drivers tap and install SteelSeries ExactMouse to disable macOS mouse acceleration (currently disabled in favor of the preferences solution in macos.sh)
  # execute "brew tap caskroom/drivers" "brew tap caskroom/drivers"
  # execute "brew cask install steelseries-exactmouse-tool" "brew cask install steelseries-exactmouse-tool"

  # Install VS Code and packages
  execute "brew cask install visual-studio-code" "brew cask install visual-studio-code"
  # Install VS Code extension Docker
  execute "code --install-extension PeterJausovec.vscode-docker" "code --install-extension PeterJausovec.vscode-docker"
  # Install VS Code extension Prettier
  execute "code --install-extension esbenp.prettier-vscode" "code --install-extension esbenp.prettier-vscode"
  # Install VS Code extension WordCounter
  execute "code --install-extension kirozen.wordcounter" "code --install-extension kirozen.wordcounter"
  # Install VS Code extension Vim
  execute "code --install-extension vscodevim.vim" "code --install-extension vscodevim.vim"
  # Install VS Code extension Open In GitHub
  execute "code --install-extension sysoev.vscode-open-in-github" "code --install-extension sysoev.vscode-open-in-github"
  # Install VS Code extension snapshot-tools
  execute "code --install-extension asvetliakov.snapshot-tools" "code --install-extension asvetliakov.snapshot-tools"
  # Install VS Code extension Rainbow CSV
  execute "code --install-extension mechatroner.rainbow-csv" "code --install-extension mechatroner.rainbow-csv"
  # Install VS Code extension VS Live Share
  execute "code --install-extension ms-vsliveshare.vsliveshare" "code --install-extension ms-vsliveshare.vsliveshare"
  # Install VS Code extension Bracket Pair Colorizer 2
  execute "code --install-extension CoenraadS.bracket-pair-colorizer-2" "code --install-extension CoenraadS.bracket-pair-colorizer-2"
  # Install VS Code extension Markdown Preview Enhanced
  execute "code --install-extension shd101wyy.markdown-preview-enhanced" "code --install-extension shd101wyy.markdown-preview-enhanced"
  # Install VS Code extension Activitus Bar
  execute "code --install-extension Gruntfuggly.activitusbar" "code --install-extension Gruntfuggly.activitusbar"
  # Install VS Code extension vscode-styled-components
  execute "code --install-extension jpoissonnier.vscode-styled-components" "code --install-extension jpoissonnier.vscode-styled-components"

  # Install VS Code Insiders Build
  execute "brew cask install visual-studio-code-insiders" "brew cask install visual-studio-code-insiders"

  # Install Oni
  execute "brew cask install oni" "brew cask install oni"

  # Install Atom and packages as backup to VS Code
  execute "brew cask install atom" "brew cask install atom"
  execute "apm install atom-alignment" "apm install atom-alignment"
  execute "apm install atom-no-tab-close-button" "apm install atom-no-tab-close-button"
  execute "apm install busy-signal" "apm install busy-signal"
  execute "apm install language-docker" "apm install language-docker"
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
  # This is broken as of Atom 1.19.0 https://github.com/mpeterson2/save-session/issues/163
  # execute "apm install save-session" "apm install save-session"
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

  # Install Flume Instagram desktop app https://flumeapp.com/
  execute ""brew cask install flume "brew cask install flume"

  # Install Mac App Store software
  # execute "brew install mas" "brew install mas"
  # execute "mas install 1176895641" "mas install 1176895641" # Spark - Love your email again
  # execute "mas install 409789998" "mas install 409789998" # Twitter (official client)
  # execute "mas install 1006184923" "mas install 1006184923" # Kiwi for Gmail Lite
  # execute "mas install 1351639930" "mas install 1351639930" # Gifski

  # Install ImageOptim-CLI ("Automates ImageOptim, ImageAlpha, and JPEGmini for Mac [for] batch optimisation of images")
  # execute "brew install imageoptim-cli" "brew install imageoptim-cli"
  # Install ImageOptim image optimization tool
  execute "brew cask install imageoptim" "brew cask install imageoptim"
  # Install ImageAlpha image optimization tool
  execute "brew cask install imagealpha" "brew cask install imagealpha"
  # Install JPEGmini Lite image optimizer
  # execute "mas install 525742250" "mas install 525742250"

  # Install Optimage (better than JPEGmini?)
  # execute "brew cask install optimage" "brew cask install optimage"

  success "Homebrew formulae installed!"
}

main
