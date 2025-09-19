import os
import requests
from bs4 import BeautifulSoup
from typing import List
from openai import OpenAI
import ollama
from IPython.display import Markdown, display, update_display
import gradio as gr

import warnings
warnings.filterwarnings("ignore", category=DeprecationWarning)

from dotenv import load_dotenv
load_dotenv(override=True)