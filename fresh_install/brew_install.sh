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

    # For Git commit signing
    "gpg"
    "pinentry-mac"

    # "hub"
    "node"
    "yarn"
    "zsh"
    "zsh-completions"
    # Best PNG optimizer https://goo.gl/WCWW3D
    "pngquant"
    # FTP and other tools https://apple.stackexchange.com/a/348495/36202
    "inetutils"
  )

  for i in ${!formulae[*]}; do
    formula="${formulae[$i]}"
    [ $(brew list "$formula" &> /dev/null; printf $?) -eq 0 ] \
      && success "$formula" \
      || execute "brew install $formula" "brew install $formula"
  done

  # Set Git reconciliation to merge (the default strategy)
  git config --global pull.rebase false

  # Install diff-highlight module and set it as default pager
  make -C $(brew --prefix git)/share/git-core/contrib/diff-highlight
  ln -sf "$(brew --prefix git)/share/git-core/contrib/diff-highlight/diff-highlight" "$(brew --prefix git)/bin/diff-highlight"

  # Install vim packages
  mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim  # pathogen.vim: runtime path manager for easy plugin installation https://github.com/tpope/vim-pathogen
  cd ~/.vim/bundle
  git clone git://github.com/tpope/vim-sleuth.git  # sleuth.vim: automatically detect buffer indentation settings and configure based on that https://github.com/tpope/vim-sleuth

  # Google Chrome Browser and extensions
  execute "brew install --cask google-chrome" "brew install --cask google-chrome"
  # Only install untrusted extensions with limited permissions (not "Read and change all your data on the websites that you visit")
  # For extensions you want that need lots of permissions, review the code and save it to this repo,
  # such as utmstrip.user.js and javascript-errors-notifier/
  # TODO: Make list of used extensions here

  # Google Chrome Canary
  execute "brew install --cask google-chrome-canary" "brew install --cask google-chrome-canary"
  # Google Chrome Canary
  execute "brew install --cask chromium" "brew install --cask chromium"
  # Firefox browser
  execute "brew install --cask firefox" "brew install --cask firefox"
  # Safari Technical Preview browser
  execute "brew install --cask safari-technology-preview" "brew install --cask safari-technology-preview"
  # Microsoft Edge browser
  execute "brew install --cask microsoft-edge" "brew install --cask microsoft-edge"

  execute "brew install --cask hyper" "brew install --cask hyper"
  execute "brew install --cask slack" "brew install --cask slack"
  execute "brew install --cask discord" "brew install --cask discord"
  # execute "brew install --cask caprine" "brew install --cask caprine"

  execute "brew install --cask whatsapp" "brew install --cask whatsapp"
  execute "brew install --cask signal" "brew install --cask signal"
  execute "brew install --cask skype" "brew install --cask skype"
  execute "brew install --cask zoom" "brew install --cask zoom"

  execute "brew install --cask keybase" "brew install --cask keybase"

  # Currently disabled because version 2.4.3 causes Inertia Scrolling (aka Momentum Scrolling) to fail in macOS 10.15 Catalina
  # execute "brew install --cask magicprefs" "brew install --cask magicprefs"
  execute "brew install --cask middleclick" "brew install --cask middleclick"
  # # Open MiddleClick in order to *manually* do the following:
  # # 1. Accept the Accessibility settings
  # # 2. Set the setting to "3 Finger Click"
  open -a MiddleClick
  # # This sets the number of fingers to 2 (currently disabled because of mis-clicks)
  # defaults write com.rouge41.middleClick fingers 2
  execute "brew install --cask menumeters" "brew install --cask menumeters"
  # Install Disk Inventory X (disk space usage utility)
  execute "brew install --cask disk-inventory-x" "brew install --cask disk-inventory-x"
  # Install Yippy clipboard manager
  execute "brew install --cask yippy" "brew install --cask yippy"
  # DO NOT USE (use Yippy instead - see above) Install Maccy clipboard manager
  # execute "brew install --cask maccy" "brew install --cask maccy"
  # DO NOT USE (use Maccy instead - see above) Install Flycut clipboard manager
  # Currently commented out because of this missing feature:
  # https://github.com/TermiT/Flycut/pull/117
  # Until that PR is merged, use the fork: https://github.com/unkhz/Flycut/releases/tag/1.8.3
  # execute "brew install --cask flycut" "brew install --cask flycut"
  # Install KeepingYouAwake - Prevent your Mac from sleeping
  execute "brew install --cask keepingyouawake" "brew install --cask keepingyouawake"
  # Install ngrok: Secure introspectable tunnels to localhost
  execute "brew install --cask ngrok" "brew install --cask ngrok"
  # Install Arq Backup
  execute "brew install --cask arq" "brew install --cask arq"
  # Install QLStephen plain text file Quick Look plugin
  execute "brew install --cask qlstephen" "brew install --cask qlstephen"
  # Install WebP Quick Look plugin
  execute "brew install --cask webpquicklook" "brew install --cask webpquicklook"
  # Install iterm2 Terminal Emulator
  execute "brew install --cask iterm2" "brew install --cask iterm2"
  # Install Adobe Acrobat Reader DC
  execute "brew install --cask adobe-acrobat-reader" "brew install --cask adobe-acrobat-reader"
  # Install Kap screen capture app (also exports to gif)
  execute "brew install --cask kap" "brew install --cask kap"
  # Install Google Music Manager
  execute "brew install --cask music-manager" "brew install --cask music-manager"
  # Install VLC
  execute "brew install --cask vlc" "brew install --cask vlc"
  # Install KeyboardCleanTool
  execute "brew install --cask keyboardcleantool" "brew install --cask keyboardcleantool"
  # Install KeePassXC Password Manager
  execute "brew install --cask keepassxc" "brew install --cask keepassxc"
  # Install LibreOffice for PDF editing
  execute "brew install --cask libreoffice" "brew install --cask libreoffice"
  # Install Krisp.ai noise cancellation software
  execute "brew install --cask krisp" "brew install --cask krisp"

  # Add drivers tap and install SteelSeries ExactMouse to disable macOS mouse acceleration (currently disabled in favor of the preferences solution in macos.sh)
  # execute "brew tap homebrew/cask-drivers" "brew tap homebrew/cask-drivers"
  # execute "brew install --cask steelseries-exactmouse-tool" "brew install --cask steelseries-exactmouse-tool"

  # Install VS Code and packages
  execute "brew install --cask visual-studio-code" "brew install --cask visual-studio-code"
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
  # Install VS Code extension Error Lens
  execute "code --install-extension usernamehw.errorlens" "code --install-extension usernamehw.errorlens"
  # Install VS Code extension Multiple cursor case preserve
  execute "code --install-extension Cardinal90.multi-cursor-case-preserve" "code --install-extension Cardinal90.multi-cursor-case-preserve"
  # Install VS Code extension Parameter Hints
  # Currently disabled due to possible confusion of students while teaching
  # execute "code --install-extension DominicVonk.parameter-hints" "code --install-extension DominicVonk.parameter-hints"

  # Install VS Code Insiders Build
  execute "brew install --cask visual-studio-code-insiders" "brew install --cask visual-studio-code-insiders"

  # Install Oni
  execute "brew install --cask oni" "brew install --cask oni"

  # Install Atom and packages as backup to VS Code
  execute "brew install --cask atom" "brew install --cask atom"
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
  execute "brew install --cask sublime-text" "brew install --cask sublime-text"

  # Install beta versions of casks
  execute "brew tap caskroom/versions" "brew tap caskroom/versions"
  # For Mac users, the GPG Suite allows you to store your GPG key passphrase in the Mac OS Keychain.
  # https://help.github.com/en/github/authenticating-to-github/signing-commits
  execute "brew install --cask gpgtools-beta" "brew install --cask gpgtools-beta"

  # Install VeraCrypt and OSXFuse dependency
  execute "brew install --cask osxfuse" "brew install --cask osxfuse"
  execute "brew install --cask veracrypt" "brew install --cask veracrypt"

  # Edit: Removed Flume as of July 2020, because Instagram
  # Direct Messages are available on the web:
  # https://www.instagram.com/direct/inbox/
  #
  # Install Flume Instagram desktop app https://flumeapp.com/
  # execute ""brew install --cask flume "brew install --cask flume"

  # Install Mac App Store software
  # execute "brew install mas" "brew install mas"
  # execute "mas install 1176895641" "mas install 1176895641" # Spark - Love your email again
  # execute "mas install 409789998" "mas install 409789998" # Twitter (official client)
  # execute "mas install 1006184923" "mas install 1006184923" # Kiwi for Gmail Lite
  # execute "mas install 1351639930" "mas install 1351639930" # Gifski

  # Install ImageOptim-CLI ("Automates ImageOptim, ImageAlpha, and JPEGmini for Mac [for] batch optimisation of images")
  # execute "brew install imageoptim-cli" "brew install imageoptim-cli"
  # Install ImageOptim image optimization tool
  execute "brew install --cask imageoptim" "brew install --cask imageoptim"
  # Install ImageAlpha image optimization tool
  execute "brew install --cask imagealpha" "brew install --cask imagealpha"
  # Install JPEGmini Lite image optimizer
  # execute "mas install 525742250" "mas install 525742250"

  # Install ColorSlurp color picker
  execute "mas install 1287239339" "mas install 1287239339"

  # Install Optimage (better than JPEGmini?)
  # execute "brew install --cask optimage" "brew install --cask optimage"

  # Install Muzzle: "Silence embarrassing notifications while screensharing"
  execute "brew install --cask muzzle" "brew install --cask muzzle"

  success "Homebrew formulae installed!"
}

main
