# bash-specific rc such as alias, helper
if [ -n "$BASHPID" ] && [ -r ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

PATH=$HOME/opt/bin:$PATH

export PATH
