# Install packages
sudo dnf install -y jq bash-completion vim-enhanced tree tmux wget ansible-core nmap-ncathelm git

# Setup Fuzzy Finder
bash -c "$(curl -s https://raw.githubusercontent.com/junegunn/fzf/master/install)" -s '--all'

# Setup Git Prompt
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

# Setup Vim

cat >> ~/.vimrc << eof
set ruler
filetype on         	" turn on file detection
filetype plugin on  	" load file type plugin
filetype indent on  	" turn on file type based indention scripts
eof

# Setup .bashrc

cat >> ~/.bashrc << eof

# Beautify less
export LESSOPEN="|pygmentize -g %s"
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --window=-4'

# oc edit with vim only
export KUBE_EDITOR="vim"

# Aliases
alias ll='ls -la'
alias vi='vim'

# Configure less
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --window=-4'

# Configure history
export HISTTIMEFORMAT="%Y.%m.%d %H:%M:%S "
export HISTSIZE=-1
shopt -s histappend

# Configure prompt
PS1='[\u@\h $(tput bold)\e[1;35m\w\e[0m\n\$ '

# Configure git prompt
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source "$HOME/.bash-git-prompt/gitprompt.sh"
fi

umask 0027
set -o vi

eof
