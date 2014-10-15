# Set architecture flags
export ARCHFLAGS="-arch x86_64"

# Ensure user-installed binaries take precedence
export PATH=/usr/local/opt/coreutils/libexec/gnubin:~/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin:/usr/local/heroku/bin:$PATH

export MANPATH=/usr/local/opt/coreutils/libexec/gnuman:$MANPATH

# Load ~/.extra: can be used for other settings you don’t want to commit.
for file in ~/.{bash_prompt,extra,python,colors}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

export EDITOR='vim'

# Load .bashrc if it exists
test -f ~/.bashrc && source ~/.bashrc

# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
  source "$(brew --prefix)/etc/bash_completion";
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion;
fi;

# Alias Github's hub to git https://github.com/github/hub
eval "$(hub alias -s)"

# Name your file <username>.sublime-project
function project_aware_subl {
    project_file=$(ls -a $USER.sublime-project 2>/dev/null | head -n 1)
    subl ${*:-${project_file:-.}}
}

function svndiff () {
  svn diff ${1+"$@"} | colordiff | less -R
}

# Load chruby if it exists
test -f /usr/local/share/chruby/chruby.sh && source /usr/local/share/chruby/chruby.sh
test -f /usr/local/share/chruby/auto.sh && source /usr/local/share/chruby/auto.sh

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
  colorflag="--color"
else # OS X `ls`
  colorflag="-G"
fi

alias ll="ls -laF ${colorflag}"

# Always use color output for `ls`
alias ls="command ls ${colorflag}"
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

alias e='project_aware_subl'
alias st='stree'

alias s='fab run'
alias swu='workon sendwithus && cd ~/projects/sendwithus'
