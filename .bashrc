# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true
# cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

export WORKON_HOME=$HOME/.virtualenvs

# install using the system version of pip
syspip(){
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

source /usr/local/bin/virtualenvwrapper.sh
