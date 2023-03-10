# If you come from bash you might have to change your $PATH.
eval "$(/opt/homebrew/bin/brew shellenv)"

# nvm config
# Until tsm suports Node 17.0.1 https://github.com/lukeed/tsm/issues/13
# export NVM_DIR="$HOME/.nvm"
# [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
# [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Use the Homebrew version of Ruby, to avoid problems
# with the default macOS version
# export PATH=/opt/homebrew/opt/ruby/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/k/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"
DISABLE_AUTO_TITLE="true"
function precmd () {
  echo -ne "\033]0;$(print -rD $PWD)\007"
}
precmd

function preexec () {
  # Using "cut" for getting only the first word of the command
  # print -Pn "\e]0;🚀 $(echo $1 | cut -d " " -f1) $(print -rD $PWD) ($1)\a"
  print -Pn "\e]0;🚀 $(print -rD $PWD) $1 🚀\a"
}

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set window title to same as tab title (for Hyper.app terminal tabs).
# Disabled because of setting the tab title above using precmd and preexec
# functions
# export ZSH_THEME_TERM_TITLE_IDLE="%18<..<%~%<<"

# echo -ne "\e]1;$PWD\a" && clear

# Add path to Yarn global binaries
if [ -x "$(command -v yarn)" ]; then export PATH="$PATH:`yarn global bin`"; fi

# OPAM configuration
#. /Users/k/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
#[[ -f /Users/k/.config/yarn/global/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/k/.config/yarn/global/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
#[[ -f /Users/k/.config/yarn/global/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/k/.config/yarn/global/node_modules/tabtab/.completions/sls.zsh

# Add all untracked files and enter patch mode
# Ref: https://github.com/robbyrussell/oh-my-zsh/pull/6901
alias ganpa='git add --intent-to-add . && git add --patch'

# Enable emacs mode for bindkey
bindkey -e

# Enable word skipping with alt + arrows
bindkey '\e\e[D' backward-word # Skip one word backwards (alt-left arrow)
bindkey '\e\e[C' forward-word # Skip one word forwards (alt-right arrow)

# Move cursor to start and end of line with command + arrows
# doesn't work, don't know why
#bindkey '\e\e[E' beginning-of-line
#bindkey '\e\e[F' end-of-line
# Location of PostgreSQL database
export PGDATA=/opt/homebrew/var/postgresql@14

# Fix "signing failed: Inappropriate ioctl for device" error with gpg
# https://stackoverflow.com/a/57591830/1268612
export GPG_TTY=$(tty)

# Prevent zsh from sharing histories between terminal tabs
# https://superuser.com/a/1248123/157255
unsetopt inc_append_history
unsetopt share_history

# Set Locale Category because of gettext bug, which causes
# Vim to output strange errors like:
# Warning: Failed to set locale category LC_NUMERIC to en_AT.
# Warning: Failed to set locale category LC_TIME to en_AT.
# Warning: Failed to set locale category LC_COLLATE to en_AT.
# Warning: Failed to set locale category LC_MONETARY to en_AT.
# Warning: Failed to set locale category LC_MESSAGES to en_AT.
# Ref: https://github.com/Homebrew/homebrew-core/issues/41139
export LC_ALL=en_US.UTF-8
# Use Homebrew Chromium because npm version
# does not yet work on M1 Macs
# https://github.com/puppeteer/puppeteer/issues/6622#issuecomment-787912758
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export PUPPETEER_EXECUTABLE_PATH=`which chromium`

# Fix "signing failed: Inappropriate ioctl for device" error with gpg
# https://stackoverflow.com/a/57591830/1268612
export GPG_TTY=$(tty)
# https://reactnative.dev/docs/environment-setup#:~:text=Configure%20the%20ANDROID_SDK_ROOT%20environment%20variable
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools

# Temporary workaround for VS Code 1.74 to configure terminal to use Zsh history file
# https://github.com/microsoft/vscode/issues/168396#issuecomment-1343000046
HISTFILE="$HOME/.zsh_history"

alias pnpmpatch="pnpm patch --edit-dir ./node_modules/.pnpm-patch"
alias pnpmpatch-commit="pnpm patch-commit ./node_modules/.pnpm-patch && rm -r ./node_modules/.pnpm-patch"
