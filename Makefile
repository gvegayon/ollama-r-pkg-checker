ifndef REPO
REPO := UofUEpiBio/epiworldR
endif

ifndef PKG
PKG := epiworldR
endif

ifndef MODEL
MODEL:= deepseek-r1:7b # deepseek-v3.1:671b-cloud
endif

create:
	@echo "Creating Ollama model: rpkgchkr:latest"
	ollama create rpkgchkr:latest -f Modelfile
