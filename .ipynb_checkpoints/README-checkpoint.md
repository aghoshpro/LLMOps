# Local Environment Setup

### If `pyproject.toml` file is given then run the following to sync

```sh
uv sync
```
### Else

### Initialize `uv` pkg manager
```sh
uv init
```

### Install venv
```sh
uv venv --python 3.13  
```
#### OUTPUT
```
Using CPython 3.13.3
Creating virtual environment at: .venv (ignored by github)
Activate with: .venv\Scripts\activate
```

### Activate venv

```sh
.venv\Scripts\activate
```

### Add pkg 

```sh
uv add scipy
```

#### OUTPUT
```
(test_llm) Z:\Git_PhD\test\test_llm>uv add flask 
Resolved 9 packages in 164ms
Prepared 3 packages in 122ms
░░░░░░░░░░░░░░░░░░░░ [0/8] Installing wheels...
Installed 2 packages in 2.06s
 + numpy==2.3.2
 + scipy==1.16.1
```

### Add pkgs from `requirements.txt`

```sh
uv add -r requirements.txt
```

### if `pyproject.toml` file is given then run the following

```sh
uv sync
```