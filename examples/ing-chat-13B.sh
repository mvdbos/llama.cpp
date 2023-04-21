#!/bin/bash

cd "$(dirname "$0")/.." || exit

MODEL="${MODEL:-./models/7B/ggml-model-q4_0.bin}"
#MODEL="${MODEL:-./models/13B/ggml-model-q4_0.bin}"
#MODEL="${MODEL:-./models/ggml-alpaca-7b-q4.bin}"
USER_NAME="${USER_NAME:-User}"
PROMPT="${PROMPT:-./prompts/ing-chat-prompt.txt}"

# Adjust to the number of CPU cores you want to use.
N_THREAD="${N_THREAD:-8}"
# Number of tokens to predict (made it larger than default because we want a long interaction)
N_PREDICTS="${N_PREDICTS:-2048}"

# Note: you can also override the generation options by specifying them on the command line:
# For example, override the context size by doing: ./chatLLaMa --ctx_size 1024
#GEN_OPTIONS="${GEN_OPTIONS:---ctx_size 2048 --temp 0.7 --top_k 40 --top_p 0.5 --repeat_last_n 256 --batch_size 1024 --repeat_penalty 1.17647}"
GEN_OPTIONS="${GEN_OPTIONS:---ctx_size 2048 --temp 0.1 --top_k 40 --top_p 0.1 --batch_size 1024 --repeat_penalty 1}"

# shellcheck disable=SC2086 # Intended splitting of GEN_OPTIONS
./main $GEN_OPTIONS \
  --model "$MODEL" \
  --threads "$N_THREAD" \
  --n_predict "$N_PREDICTS" \
  --color --interactive \
  --reverse-prompt "${USER_NAME}:" \
  -f "${PROMPT}"
