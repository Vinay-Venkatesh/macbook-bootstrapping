# powerlevel10k
[[ -r ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme ]] && \
  source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme

# Autosuggestions
[[ -r ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
  source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Syntax highlighting (MUST be last)
[[ -r ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
  source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Welcome message
[[ -r ~/dotfiles/zsh/welcome.sh ]] && source ~/dotfiles/zsh/welcome.sh

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
