ifndef REPO
REPO := UofUEpiBio/epiworldR
endif

ifndef PKG
PKG := epiworldR
endif

ifndef MODEL
MODEL:= deepseek-r1:7b # deepseek-v3.1:671b-cloud
endif

run:
	echo "Download the GitHub repository <https://github.com/$(REPO)>, inspect all its files, and evaluate it using the following checklist:\n" > $(PKG)_query.txt && \
	echo "<START OF CHECKLIST>" >> $(PKG)_query.txt && \
	cat checklist.md >> $(PKG)_query.txt && \
	echo "<END OF CHECKLIST>" >> $(PKG)_query.txt && \
	echo "Ensure that you either use GitHub\'s API or navigate to the repository to gather the necessary information about the package." >> $(PKG)_query.txt && \
	$(MAKE) run-cat -B


run-tidyverse:
	echo "Download the GitHub repository <https://github.com/$(REPO)>, inspect all its files, and evaluate if it is following the tidyverse style guide: <https://github.com/tidyverse/style/tree/gh-pages>." > $(PKG)_query.txt && \
	echo "Ensure that you either use GitHub\'s API or navigate to the repository to gather the necessary information about the package." >> $(PKG)_query.txt && sleep 2 && \
 	$(MAKE) run-cat -B

run-cat:
	ollama run $(MODEL) "$(shell cat $(PKG)_query.txt)"

start-ollama:
	ollama serve > ollama.log 2>&1 &

setup-key:
	cp ./id_ed25519 /root/.ssh/id_ed25519


