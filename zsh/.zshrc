source ${HOME}/.zsh_plugins

setopt histignorealldups

alias vim=nvim
export EDITOR=vim

source ~/.fzf.zsh 

[ -s "/usr/share/nvm/init-nvm.sh" ] && source /usr/share/nvm/init-nvm.sh

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

export PATH=$PATH:${HOME}.local/bin

. /opt/homebrew/opt/asdf/libexec/asdf.sh


source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
