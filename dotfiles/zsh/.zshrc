# Welcome banner (only for interactive shells)
if [[ -o interactive && -z "$WELCOME_SHOWN" ]]; then
  export WELCOME_SHOWN=1

  TIME=$(date '+%A · %d %B %Y · %I:%M %p')
  CACHE_FILE="$HOME/.cache/thought_of_the_day.txt"
  TODAY=$(date '+%Y-%m-%d')

  mkdir -p "$HOME/.cache"

  # Fetch once per day
  if [[ ! -f "$CACHE_FILE" ]] || ! grep -q "$TODAY" "$CACHE_FILE"; then
    THOUGHT=$(curl -s --max-time 2 https://zenquotes.io/api/today \
      | sed -n 's/.*"q":"\([^"]*\)".*/\1/p')

    if [[ -n "$THOUGHT" ]]; then
      echo "$TODAY|$THOUGHT" > "$CACHE_FILE"
    fi
  fi

  # Read cached thought
  THOUGHT=$(cut -d'|' -f2 "$CACHE_FILE" 2>/dev/null)

  # Fallback (never empty)
  [[ -z "$THOUGHT" ]] && THOUGHT="Focus beats intelligence when applied consistently."
    echo "--"
    echo "🕒  $TIME"
    echo "💡  $THOUGHT"
    echo "--"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
