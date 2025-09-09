import os
from dotenv import load_dotenv
from openai import OpenAI  
from IPython.display import Markdown, display, update_display
import gradio as gr


load_dotenv(override=True)
openai_api_key = os.getenv('OPENAI_API_KEY')
anthropic_api_key = os.getenv('ANTHROPIC_API_KEY')
google_api_key = os.getenv('GOOGLE_API_KEY')
ollama_api_key = os.getenv('OLLAMA_API')

if openai_api_key:
    print(f"OpenAI API Key exists and begins {openai_api_key[:8]}")
else:
    print("OpenAI API Key not set")
    
if anthropic_api_key:
    print(f"Anthropic API Key exists and begins {anthropic_api_key[:7]}")
else:
    print("Anthropic API Key not set")

if google_api_key:
    print(f"Google API Key exists and begins {google_api_key[:8]}")
else:
    print("Google API Key not set")

if ollama_api_key:
    print(f"Ollama API Key exists and begins {ollama_api_key[:8]}")
else:
    print("Ollama API Key not set")



# Connect to OpenAI, Anthropic

OPENAI = OpenAI()
MODEL_IN_USE = "gpt-4o-mini" # 'gpt-4.1-mini', 'gpt-4.1-nano', 'gpt-4.1-turbo', 'gpt-4.1'

system_message = "You are an assistant that is great at telling quirky jokes" 
user_prompt = "Tell a light-hearted joke for an audience of biologists"
prompts = [
    {"role": "system", "content": system_message},
    {"role": "user", "content": user_prompt}
  ]


completion = OPENAI.chat.completions.create(
    model= MODEL_IN_USE,
    messages=prompts,
    temperature=0.5)
print('\n\n')
print(completion.choices[0].message.content)
print('\n\n')