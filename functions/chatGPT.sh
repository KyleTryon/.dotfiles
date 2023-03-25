#!/bin/bash
chatGPT() {
  input=${*:-$(cat -)}
  response=$(curl -s https://api.openai.com/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -d "{
    \"model\": \"gpt-3.5-turbo\",
    \"messages\": [{\"role\": \"system\", \"content\": \"You are a helpful CLI tool for software developers in a linux terminal.\"}, {\"role\": \"user\", \"content\": \"$input\"}],
    \"n\": 1
  }")
  if [[ $(jq -e '.error' <<< "$response") && $? -eq 0 ]]; then
    printf '%s' "Error: $(jq '.error.message' <<< "$response")"
    return 1
  fi
  message=$(printf '%s' "$response" | jq -r '.choices[0].message.content')
  echo
  if command -v highlight &> /dev/null ; then
    message=$(printf '%s' "$message" | highlight --syntax=markdown --out-format=ansi)
  else
    echo "$message"
  fi
  echo "$message"
}
