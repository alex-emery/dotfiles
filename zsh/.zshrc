# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ${HOME}/.zsh_plugins

# set where plugins are cloned to
ZPLUGINDIR=${ZDOTDIR:-$HOME/.config/zsh}/plugins

# ohmyzsh wants a cache dir for things
export ZSH_CACHE_DIR=${HOME}/.config/zsh/plugins/ohmyzsh/cache

# and cache/completion to exist for things like kubectl completion
[ -d $ZPLUGINDIR/ohmyzsh/cache/completions ] || mkdir $ZPLUGINDIR/ohmyzsh/cache/completions
fpath+=$ZPLUGINDIR/ohmyzsh/cache/completions

# add brew completions
fpath+=/opt/homebrew/share/zsh/site-functions

# make a github repo plugins list
repos=(
  # not-sourcable plugins
  romkatv/zsh-bench

  # projects with nested plugins
  belak/zsh-utils
  ohmyzsh/ohmyzsh

  # regular plugins
  romkatv/zsh-defer
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-history-substring-search
  zdharma-continuum/fast-syntax-highlighting
  Aloxaf/fzf-tab
  jeffreytse/zsh-vi-mode

  #theme
  romkatv/powerlevel10k
)

plugin-clone $repos

# handle non-standard plugins
export PATH="$ZPLUGINDIR/zsh-bench:$PATH"

# Setup zsh-vi-mode to not break stuff
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
# source other plugins
beforeCompInit=(
  powerlevel10k # theme
  zsh-utils/history
  zsh-utils/completion
  zsh-utils/utility
  zsh-vi-mode
    
  ## omz plugins
  ohmyzsh/plugins/history-substring-search
  ohmyzsh/plugins/z
  ohmyzsh/plugins/docker
  ohmyzsh/plugins/kubectl

)

plugin-source $beforeCompInit

autoload -Uz compinit
compinit

# some stuff in ohmyzsh/lib wants access to compdef...
# handle non-standard plugins
for file in $ZPLUGINDIR/ohmyzsh/lib/*.zsh; do
  source $file
done


afterCompInit=(
  fzf-tab # has to be after compinit && before fast-syntax-highlighting and zsh-autosuggestions

  #zsh-defer # everything after this is "deferred". technically not needed with p10k
  fast-syntax-highlighting
  zsh-autosuggestions
)

plugin-source $afterCompInit


## Plugin setup
# requires fzf
[[ ! -f ~/.fzf.zsh ]] || source ~/.fzf.zsh 
[[ ! -f /etc/profile.d/fzf.zsh ]] || . /etc/profile.d/fzf.zsh
# history substring search bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt histignorealldups
setopt list_ambiguous
setopt hist_expire_dups_first

alias vim=nvim
export EDITOR=vim


#[ -s "/usr/share/nvm/init-nvm.sh" ] && zsh-defer source /usr/share/nvm/init-nvm.sh

#export NVM_DIR="$HOME/.nvm"
#[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && zsh-defer \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
#[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && zsh-defer \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
#

export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

export PATH=$PATH:${HOME}/.local/bin

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    [ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
    source /usr/share/nvm/nvm.sh
    source /usr/share/nvm/bash_completion
    source /usr/share/nvm/install-nvm-exec
elif [[ "$OSTYPE" == "darwin"* ]]; then

    [ -s "/usr/share/nvm/init-nvm.sh" ] && source /usr/share/nvm/init-nvm.sh

    export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

    . /opt/homebrew/opt/asdf/libexec/asdf.sh
    source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
