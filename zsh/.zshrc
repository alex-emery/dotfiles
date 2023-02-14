source ${HOME}/.zsh_plugins

setopt histignorealldups

alias vim=nvim
export EDITOR=vim

source ~/.fzf.zsh 

[ -s "/usr/share/nvm/init-nvm.sh" ] && zsh-defer source /usr/share/nvm/init-nvm.sh

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && zsh-defer \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && zsh-defer \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

export PATH=$PATH:${HOME}.local/bin
