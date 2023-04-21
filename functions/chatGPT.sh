#!/bin/bash
# A CLI interface for ChatGPT, tuned to answer Linux-related questions
# Usage: chatGPT [OPTION]... [INPUT]
# Options:
#   -f, --format FORMAT   Specify the output format
#                         Default: markdown
#                         Options:
#                           markdown (m)
#                           json (j)
#                           term (t)
#   -h, --help            Display this help message and return
#
# Example:
#   chatGPT -f t "How do I install a package in Ubuntu?"
#   chatGPT "How do I install a package in Ubuntu?"
chatGPT() {
  # Function to display help message
  display_help() {
    echo "Usage: $0 [OPTION]... [INPUT]"
    echo "Accept input either as an argument or piped from another command."
    echo ""
    echo "Options:"
    echo "  -f, --format FORMAT   Specify the output format
                        Default: markdown
                        Options:
                          markdown (m)
                          json (j)
                          term (t)"
    echo "  -h, --help            Display this help message and return"
    echo ""
  }

  # Function to process the input
  process_input() {
    local input="$1"
    local format="$2"

    # Check if input is empty
    if [[ -z "$input" ]]; then
      echo "Error: No input provided."
      return 1
    fi

    # Add your processing logic here based on the format
    case "$format" in
    markdown | m)
      # Process input in markdown format
      system_instructions="You are a helpful Linux mentor. Respond in markdown format. Keep responses short."
      response=$(fetch_response "$input" "$system_instructions" | jq -r '.choices[0].message.content')
      if command -v highlight &>/dev/null; then
        response=$(printf '%s' "$response" | highlight --syntax=markdown --out-format=ansi)
      fi
      ;;
    json | j)
      # Process input in json format
      system_instructions="Format all responses as a JSON object."
      response=$(fetch_response "$input" "$system_instructions" | jq -r '.choices[0].message.content')
      if command -v highlight &>/dev/null; then
        response=$(printf '%s' "$response" | highlight --syntax=json --out-format=ansi)
      fi
      ;;
    term | t)
      # Process input in term format
      # Generate some metadata
      CURRENT_OS=$(lsb_release -d | awk -F"\t" '{print $2}')
      system_instructions="Return only the linux executable command for the requested task. Current OS: $CURRENT_OS; USER_PATH: $PATH"
      response=$(fetch_response "$input" "$system_instructions" | jq -r '.choices[0].message.content')
      if command -v highlight &>/dev/null; then
        response=$(printf '%s' "$response" | highlight --syntax=bash --out-format=ansi)
      fi
      ;;
    *)
      echo "Error: Unsupported format. Please use markdown, json, or term."
      return 1
      ;;
    esac
    echo "$response"
  }

  # Function to fetch response from chatGPT API
  # Arguments:
  #   prompt: The prompt to use for the chatGPT API
  #   system_instructions: The system instructions to use for the chatGPT API
  fetch_response() {
    local prompt="$1"
    local system_instructions="$2"

    if [[ -z "$OPENAI_API_KEY" ]]; then
      echo "Error: OPENAI_API_KEY is not set."
      return 1
    fi

    curl -s https://api.openai.com/v1/chat/completions \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $OPENAI_API_KEY" \
      -d "{
    \"model\": \"gpt-3.5-turbo\",
    \"messages\": [{\"role\": \"system\", \"content\": \"$system_instructions\"}, {\"role\": \"user\", \"content\": \"$prompt\"}],
    \"n\": 1
  }"

  }

  # Default format
  format="markdown"

  # Parse command-line options
  while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in
    -f | --format)
      format="$2"
      shift # past argument
      shift # past value
      ;;
    -h | --help)
      display_help
      return 0
      ;;
    *)
      # Assume any other argument is input
      input_arg="$1"
      shift # past argument
      ;;
    esac
  done

  # Check if input was provided as an argument, otherwise read from stdin
  if [[ -n "$input_arg" ]]; then
    input_data="$input_arg"
  else
    # Read piped input or from stdin if no argument is given
    input_data=$(cat)
  fi

  # Process the input with the specified format
  process_input "$input_data" "$format"
}
