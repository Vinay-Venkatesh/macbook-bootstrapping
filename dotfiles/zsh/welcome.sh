#!/bin/bash

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

    [[ -n "$THOUGHT" ]] && echo "$TODAY|$THOUGHT" > "$CACHE_FILE"
  fi

  THOUGHT=$(cut -d'|' -f2 "$CACHE_FILE" 2>/dev/null)
  [[ -z "$THOUGHT" ]] && THOUGHT="Focus beats intelligence when applied consistently."

  echo "--"
  echo "🕒  $TIME"
  echo "💡  $THOUGHT"
  echo "--"
fi
