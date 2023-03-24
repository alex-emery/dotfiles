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

.PHONY: alacritty

alacritty:
	./helpers/alacritty.sh

applications = alacritty nvim sketchybar skhd yabai tmux zsh
dotfiles:
	$(foreach app,$(applications),stow $(app);)

clean:
	$(foreach app,$(applications),stow -D $(app);)
