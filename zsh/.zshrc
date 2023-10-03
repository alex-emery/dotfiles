# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
 source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HOST_OS=$(uname -s)

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

ZVM_INIT_MODE=sourcing

# OS specific sources
if [[ ${HOST_OS} == "Linux" ]]; then
  zvm_after_init_commands+=('[ -f /etc/profile.d/fzf.zsh ] && source /etc/profile.d/fzf.zsh')
elif [[ ${HOST_OS} == "Darwin" ]]; then
  zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
fi

# source other plugins
beforeCompInit=(
  powerlevel10k # theme
  #zsh-defer
  zsh-utils/history
  zsh-utils/completion
  zsh-utils/utility
  #zsh-vi-mode
    
  ## omz plugins
  ohmyzsh/plugins/history-substring-search # says it wants to be called after highlighting
  ohmyzsh/plugins/z # must be called after compinit for tab

  zsh-defer
  ohmyzsh/plugins/docker
  ohmyzsh/plugins/kubectl
)

plugin-source $beforeCompInit
autoload -Uz compinit && compinit

# some stuff in ohmyzsh/lib wants access to compdef...
# handle non-standard plugins
for _f in $ZPLUGINDIR/ohmyzsh/lib/*.zsh; do
  source $_f
done
unset _f 


afterCompInit=(
  fzf-tab # has to be after compinit && before fast-syntax-highlighting and zsh-autosuggestions

  fast-syntax-highlighting
  zsh-autosuggestions
  zsh-vi-mode
)

plugin-source $afterCompInit


## Plugin setup
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

## Exports
export EDITOR=nvim
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH=$PATH:${HOME}/.local/bin
export GPG_TTY=$TTY

## Aliases
alias vim=nvim
alias aws-dev="aws --profile DeveloperDevelopment --region eu-west-2"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
