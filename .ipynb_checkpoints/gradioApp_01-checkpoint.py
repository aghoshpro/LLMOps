import os
import requests
from bs4 import BeautifulSoup
from typing import List
from dotenv import load_dotenv
from openai import OpenAI
import ollama
from IPython.display import Markdown, display, update_display
import gradio as gr


load_dotenv(override=True)

# Connect to OpenAI, Anthropic
OPENAI = OpenAI()
MODEL_IN_USE = "gpt-4o-mini" # 'gpt-4.1-mini', 'gpt-4.1-nano', 'gpt-4.1-turbo', 'gpt-4.1'
system_message = "You are a helpful assistant that responds in markdown" # "You are an assistant that is great at telling quirky jokes"
user_prompt = "Tell a light-hearted joke for an audience of biologists"
prompts = [
    {"role": "system", "content": system_message},
    {"role": "user", "content": user_prompt}
  ]


# Functions
def message_gpt(prompt):
    messages = [
        {"role": "system", "content": system_message},
        {"role": "user", "content": prompt}
      ]
    completion = OPENAI.chat.completions.create(
        model=MODEL_IN_USE,
        messages=messages,
    )
    return completion.choices[0].message.content

def stream_gpt(prompt):
    messages = [
        {"role": "system", "content": system_message},
        {"role": "user", "content": prompt}
      ]
    stream = OPENAI.chat.completions.create(
        model=MODEL_IN_USE,
        messages=messages,
        stream=True
    )
    result = ""
    for chunk in stream:
        result += chunk.choices[0].delta.content or ""
        yield result

def stream_claude(prompt):
    return True
    # result = claude.messages.stream(
    #     model="claude-3-haiku-20240307",
    #     max_tokens=1000,
    #     temperature=0.7,
    #     system=system_message,
    #     messages=[
    #         {"role": "user", "content": prompt},
    #     ],
    # )
    # response = ""
    # with result as stream:
    #     for text in stream.text_stream:
    #         response += text or ""
    #         yield response


def stream_ollama(prompt):
    response = ollama.chat(
        model="llama3.2",
        messages=[{"role":"user","content":prompt}]
    )
    result = ""
    for chunk in response["message"]["content"]:
        result += chunk
        yield result

def stream_model(prompt, model):
    if model=="GPT":
        result = stream_gpt(prompt)
    elif model=="Claude":
        result = stream_claude(prompt)
    elif model=="Ollama":
        result = stream_ollama(prompt)
    else:
        raise ValueError("Unknown model")
    yield from result

## Gradio
view = gr.Interface(
    fn=stream_model,
    inputs=[gr.Textbox(label="Your Query:", lines=6), gr.Dropdown(["GPT", "Claude", "Ollama"], label="Select model", value="GPT")],
    outputs=[gr.Markdown(label="Response:")],
    flagging_mode="never"
).launch()
