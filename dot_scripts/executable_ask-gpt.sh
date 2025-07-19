#!/usr/bin/env bash


read -p "Whats Your Question?:  " query

curl https://api.openai.com/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $openai_api_key" \
  -d '{
     "model": "gpt-3.5-turbo",
     "messages": [{"role": "user", "content": "'"$query"'"}],
     "temperature": 0.7
   }'

