.PHONY: all dotfiles clean alacritty

BREW := $(shell command -v brew 2> /dev/null)

all: dotfiles

brew: Brewfile 
ifndef BREW
	$(info "Installing brew)
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash
endif
	$(info "Brew installed bundling...")
	@brew bundle

alacritty:
	./helpers/alacritty.sh

common = alacritty nvim tmux zsh
macos = yabai sketchybar skhd
linux = bspwm sxhkd rofi

OS := $(shell uname)
ifeq ($(OS), Darwin)
	applications=$(common) $(macos)
else
	applications=$(common) $(linux)
endif


dotfiles: 
	$(foreach app,$(applications),echo stowing $(app) && stow $(app);)

clean:
	$(foreach app,$(applications),stow -D $(app);)
