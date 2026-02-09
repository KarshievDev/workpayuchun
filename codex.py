#!/usr/bin/env python3
import openai
import sys
import os

# Load API key from environment variable
openai.api_key = os.getenv("OPENAI_API_KEY")

if not openai.api_key:
    print("❌ Please set your OPENAI_API_KEY environment variable.")
    sys.exit(1)

# Get the prompt from CLI args or input
prompt = " ".join(sys.argv[1:]) if len(sys.argv) > 1 else input("Prompt: ")

# Use GPT model (replacing Codex)
response = openai.ChatCompletion.create(
    model="gpt-3.5-turbo",  # Or "gpt-4" if you have access
    messages=[
        {"role": "user", "content": prompt}
    ]
)

print("\n🧠 Output:\n")
print(response.choices[0].message["content"].strip())
