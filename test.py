from langchain_ollama import OllamaEmbeddings

embeddings = OllamaEmbeddings(model="mxbai-embed-large") # mxbai-embed-large, llama3.2

sentence1 = "This is a sentence."
sentence2 = "This is another sentence."
sentence3 = "This is a third sentence."

embedding1 = embeddings.embed_query(sentence1)
# embedding2 = embeddings.embed_query(sentence2)
# embedding3 = embeddings.embed_query(sentence3)

print(embedding1)
# print(embedding2)
# print(embedding3)