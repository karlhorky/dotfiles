# Set architecture flags
export ARCHFLAGS="-arch x86_64"

# Ensure user-installed binaries take precedence
export PATH=~/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/heroku/bin:$PATH

export EDITOR='vim'

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Load .bashrc if it exists
test -f ~/.bashrc && source ~/.bashrc

# Name your file <username>.sublime-project
function project_aware_subl {
    project_file=$(ls -a $USER.sublime-project 2>/dev/null | head -n 1)
    subl ${*:-${project_file:-.}}
}

function svndiff () {
  svn diff ${1+"$@"} | colordiff | less -R
}

alias e='project_aware_subl'
alias st='stree'
alias s='foreman start -f Procfile_dev'

alias swu='workon betawithus && cd ~/development/betawithus'

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
