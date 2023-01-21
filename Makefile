.PHONY: all dotfiles 
BREW := $(shell command -v brew 2> /dev/null)
all: dotfiles

brew: Brewfile 
ifndef BREW
	$(info "Installing brew)
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash
endif
	$(info "Brew installed bundling...")
	@brew bundle

dotfiles: brew 
	@stow alacritty
	@stow nvim
	@stow sketchybar 
	@stow skhd 
	@stow yabai
	@stow tmux
	@stow zsh
