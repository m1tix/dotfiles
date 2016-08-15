#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Export
export PYTHONPATH=/usr/lib64/python3.5/site-packages
export EDITOR=vim

# Aliases
alias dot='cd ~/Documents/Git/dotfiles/'
alias ls='ls -l --color'
alias dirs='dirs -v'
alias l='ls -al'
alias t='tmux'
alias tutorial='cd ~/Code/Python/tutorial'
alias x='xrdb ~/.Xresources'
alias vim='nvim'

# Extract program
function extract()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xvjf $1     ;;
            *.tar.gz)   tar xvzf $1     ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      unrar x $1      ;;
            *.tar)      tar xvf $1      ;;
            *.tbz2)     tar xvjf $1     ;;
            *.tgz)      tar xvzf $1     ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *.7z)       7z x $1         ;;
            *)          echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}



#PS1="\w \[\033[01;32m\]> \[\033[0m\]"
#PS1="\[\033[38;5;2m\]λ\[$(tput sgr0)\]\[\033[38;5;15m\]\[$(tput sgr0)\]\[\033[38;5;3m\] \w\[$(tput sgr0)\]\[\033[38;5;15m\]\] \[$(tput sgr0)\]"
#PS1="\[\033[32m\]┌╴[\w]\[\033[0m\]\n\[\033[32m\]└╴\[\033[1;36m\]λ \[\033[0m\]"
PS1="\[\033[38;5;3m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;2m\]]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

