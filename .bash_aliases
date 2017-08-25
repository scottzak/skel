# ~/.bash_aliases: executed by bash for interactive sessions
alias vp="vi ~/.bashrc"
alias va="vi ~/.bash_aliases"
alias ve="vi ~/.bash_env"
alias vf="vi ~/.bash_functions"
alias newp=". ~/.bashrc"
alias newa=". ~/.bash_aliases"
alias newe=". ~/.bash_env"
alias newf=". ~/.bash_functions"

alias fns="typeset -F | grep -v 'f _' | sed -e's/declare -f //'"


# Git commands
alias gst="git status"
alias gcm="git commit"
alias gpo="git push origin"
alias gdiff="git diff"
alias gssh="eval $(ssh-agent -s) && ssh-add ~/.ssh/id_rsa"

# Navigation
alias cdd="cd $SLS_PROJECT_ROOT"
