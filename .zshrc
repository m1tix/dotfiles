# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mitix/.zshrc'

autoload -Uz compinit
compinit

# End of lines added by compinstall
# Export
# export PYTHONPATH=/usr/lib64/python3.5/site-packages
export EDITOR=nvim
export MYVIMRC="$HOME/.config/nvim/init.lua"

# Aliases
alias ls='ls -hl --color'
alias dirs='dirs -v'
alias tree='tree -C'
alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'
# small alias while learning C
alias gcc='gcc -Wall -std=c99 -g'
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


PROMPT=$'%F{yellow}%~%f\n%F{red}%f '
# PS1="\[\033[38;5;3m\]λ\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;2m\]\W\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
#
# source ~/.config/zsh/catppuccin-highlight.zsh
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
