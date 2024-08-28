# Install packages
sudo dnf install -y jq bash-completion vim-enhanced tree tmux wget ansible-core nmap-ncat git

# Install helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Setup Fuzzy Finder
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
sh ~/.fzf/install --all

# Setup Git Prompt
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

# Setup for OCP installation
ssh-keygen -t rsa -b 4096 -N '' -f ~/.ssh/ocp
mirror="https://mirror.openshift.com/pub/openshift-v4/clients"
ocp_version="4.13.18"
wget -O /tmp/openshift-client-linux-${ocp_version}.tar.gz ${mirror}/ocp/${ocp_version}/openshift-client-linux-${ocp_version}.tar.gz
wget -O /tmp/openshift-install-linux-${ocp_version}.tar.gz ${mirror}/ocp/${ocp_version}/openshift-install-linux-${ocp_version}.tar.gz
sudo tar -xvzf /tmp/openshift-client-linux-${ocp_version}.tar.gz -C /usr/local/bin oc
sudo tar -xvf /tmp/openshift-install-linux-${ocp_version}.tar.gz -C /usr/local/bin openshift-install
sudo sh -c "/usr/local/bin/oc completion bash > /etc/bash_completion.d/oc"
sudo chmod o+r /etc/bash_completion.d/oc
sudo sh -c "/usr/local/bin/openshift-install completion bash > /etc/bash_completion.d/openshift-install"
sudo chmod o+r /etc/bash_completion.d/openshift-install

# Setup Vim

cat >> ~/.vimrc << eof
filetype on         	" turn on file detection
filetype plugin on  	" load file type plugin
filetype indent on  	" turn on file type based indention scripts
set ruler
set tabstop=2 softtabstop=2 shiftwidth=2
set expandtab
set cursorcolumn
highlight CursorColumn ctermbg=darkblue
eof

# Setup .bashrc

cat >> ~/.bashrc << eof

# Beautify and configure less
export LESSOPEN="|pygmentize -g %s"
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --window=-4'

# oc edit with vim only
export KUBE_EDITOR="vim"

# Aliases
alias ll='ls -la'
alias vi='vim'

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
