# Set architecture flags
export ARCHFLAGS="-arch x86_64"
# Ensure user-installed binaries take precedence
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/heroku/bin:$PATH
# Load .bashrc if it exists
test -f ~/.bashrc && source ~/.bashrc

export EDITOR="subl"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

alias e="subl ."
alias st="stree"
alias s="foreman start -f Procfile_dev"

alias beta="workon betawithus && cd ~/development/betawithus"