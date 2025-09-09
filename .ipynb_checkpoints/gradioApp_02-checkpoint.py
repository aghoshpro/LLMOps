import os
import requests
from bs4 import BeautifulSoup
from typing import List
from dotenv import load_dotenv
from openai import OpenAI
import ollama
from IPython.display import Markdown, display, update_display
import gradio as gr