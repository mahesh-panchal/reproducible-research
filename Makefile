# Makefile for the Gitpod Environment

# General settings
UID := $$( id -u )
GROUP := $$( id -g )

# Conda settings
# CONDA_PKGM := mamba                  # Conda package manager to use

## PROJECT COMMANDS
# Run Nextflow workflow
analysis:
	cd analyses/carpentries-data_wrangling; \
	./run_nextflow.sh

workflow-test:
	cd analyses/carpentries-data_wrangling; \
	./run_nextflow.sh

fetch-rawdata:
	scripts/fetch_rawdata.sh

## GIT RULES
# Link template 
# git-link-template:
# 	git remote add template https://github.com/NBISweden/assembly-project-template

# Merge changes from template to current branch
# git-merge-template:
# 	git fetch template
# 	git merge template/main --allow-unrelated-histories

## CONDA RULES
# Builds conda environment to execute workflow
# nextflow-env:
#	$(CONDA_PKGM) env create --prefix "conda/nextflow-env" \
#		-f "workflow/nextflow_conda-env.yml"

## QUARTO RULES
# Render Quarto book to gh-pages branch
gh-pages: 
	cd docs/gh-pages && quarto publish gh-pages --no-browser --no-prompt

## RSTUDIO - Not needed
# Run RStudio from Rocker/verse:latest using docker-compose
rstudio-start:
	UID=$(UID) docker-compose -f rstudio-docker-compose.yml up -d
	$(info If you didn't provide a password in docker-compose.yml, then use `docker logs <container>` to see your password)

rstudio-stop:
	docker-compose -f rstudio-docker-compose.yml down

## JUPYTER
# Run Jupyter from jupyter/datascience-notebook using docker-compose
jupyter-start:
	UID=$(UID) docker-compose -f jupyter-docker-compose.yml up -d
	$(info If you didn't provide a password in docker-compose.yml, then use `docker logs <container>` to see your token)

jupyter-stop:
	docker-compose -f jupyter-docker-compose.yml down

.PHONY: fetch-rawdata
.PHONY: analysis workflow-test 
.PHONY: gh-pages
# .PHONY: git-link-template git-merge-template
.PHONY: rstudio-start rstudio-stop
.PHONY: jupyter-start jupyter-stop
