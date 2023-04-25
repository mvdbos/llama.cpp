#!/bin/bash

cd "$(dirname "$0")/.." || exit

MODEL="${MODEL:-./models/ggml-alpaca-7b-q4.bin}"
PROMPT="${PROMPT:-./prompts/ing-qa-prompt-keywords.txt}"
#PROMPT="${PROMPT:-./prompts/ing-qa-prompt.txt}"

# Adjust to the number of CPU cores you want to use.
N_THREAD="${N_THREAD:-8}"
# Number of tokens to predict (made it larger than default because we want a long interaction)
N_PREDICTS="${N_PREDICTS:--1}"

# Note: you can also override the generation options by specifying them on the command line:
# For example, override the context size by doing: ./chatLLaMa --ctx_size 1024
#GEN_OPTIONS="${GEN_OPTIONS:---ctx_size 2048 --temp 0.7 --top_k 40 --top_p 0.5 --repeat_last_n 256 --batch_size 1024 --repeat_penalty 1.17647}"
GEN_OPTIONS="${GEN_OPTIONS:---ctx_size 2048 --temp 0.2 --top_k 100 --top_p 0.9 --repeat_last_n 256 --batch_size 256 --repeat_penalty 1}"

# shellcheck disable=SC2086 # Intended splitting of GEN_OPTIONS
./main $GEN_OPTIONS \
  --model "$MODEL" \
  --threads "$N_THREAD" \
  --n_predict "$N_PREDICTS" \
  --color \
  -f "${PROMPT}"
