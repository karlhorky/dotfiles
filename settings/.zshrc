# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/k/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"
function precmd () {
  echo -ne "\033]0;$(print -rD $PWD)\007"
}
precmd

function preexec () {
  print -Pn "\e]0;🚀 $(echo $1 | cut -d " " -f1) $(print -rD $PWD) ($1)\a"
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
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

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

# Prevent zsh from sharing histories between terminal tabs
# https://superuser.com/a/1248123/157255
unsetopt inc_append_history
unsetopt share_history
