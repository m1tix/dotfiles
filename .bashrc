#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Export
#" export PYTHONPATH=/usr/lib64/python3.5/site-packages
export EDITOR=nvim

# Aliases
alias swingin='mpc clear & mpc load soundcloud://url/soundcloud.com/mitix-106877130/likes'
alias dot='cd ~/Documents/Git/dotfiles/'
alias neofetch="neofetch --gtk2 'off' --gtk3 'off' --block_range '0' '15'"
alias ls='ls -l --color'
alias dirs='dirs -v'
alias l='ls -al'
alias t='tmux'
alias tutorial='cd ~/Code/Python/tutorial'
alias x='xrdb ~/.Xresources'

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



PS1="\[\033[38;5;3m\]λ\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;2m\]\W\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
# PS1="\[\033[38;5;3m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;2m\]]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

