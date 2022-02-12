# Makefile for the Gitpod Environment

# General settings
UID := $$( id -u )
GROUP := $$( id -g )

# Conda settings
# CONDA_PKGM := mamba                  # Conda package manager to use

# R settings
# Replace Container command with Singularity, or other container engine
# Initialise to empty string along with DISTILL_IMG to use local R installation
ROCKER_CMD := docker run --user "$(UID):$(GROUP)" --rm -v "${PWD}:/home/rstudio" -w /home/rstudio
DISTILL_IMG := ghcr.io/mahesh-panchal/rocker/distill:4.1.2  # Image name and version
WEBSITE_DIR := website

# Run Nextflow workflow
analysis:
	cd analyses/carpentries-data_wrangling; \
	./run_nextflow.sh

workflow-test:
	cd analyses/carpentries-data_wrangling; \
	./run_nextflow.sh

fetch-rawdata:
	scripts/fetch_rawdata.sh

# Builds conda environment to execute workflow
# nextflow-env:
#	$(CONDA_PKGM) env create --prefix "conda/nextflow-env" \
#		-f "workflow/nextflow_conda-env.yml"

# Build the RMarkdown report
report:
	$(ROCKER_CMD) $(DISTILL_IMG) Rscript scripts/build_report.R

clean-report:

# Publish Distill website to local gh-pages branch
gh-pages: $(WEBSITE_DIR)/docs/index.html
	git subtree push --prefix $(WEBSITE_DIR)/docs . gh-pages

# Publish Distill website to gh-pages branch on Github
gh-pages-origin: $(WEBSITE_DIR)/docs/index.html
	git push origin :gh-pages
	git subtree push --prefix $(WEBSITE_DIR)/docs origin gh-pages

# Builds the Distill website
website: $(WEBSITE_DIR)/_site.yml
	$(ROCKER_CMD) $(DISTILL_IMG) Rscript scripts/build_website.R $(WEBSITE_DIR)

$(WEBSITE_DIR)/_site.yml:
	$(ROCKER_CMD) $(DISTILL_IMG) Rscript scripts/init_website.R $(WEBSITE_DIR)

clean-website:
	rm -rf $(WEBSITE_DIR)

webpages: $(WEBSITE_DIR)/docs/$(wildcard *.html)
	@echo "Please update _site.yml with links to html files"

$(WEBSITE_DIR)/docs/%.html:	$(WEBSITE_DIR)/%.Rmd
	$(ROCKER_CMD) $(DISTILL_IMG) Rscript -e 'rmarkdown::render_site("$<")'

$(WEBSITE_DIR)/%.Rmd:
	$(ROCKER_CMD) $(DISTILL_IMG) Rscript -e 'distill::create_article("$@",edit=FALSE)'

# Run RStudio from Rocker/verse:4.1.2 using docker-compose
rstudio-start:
	UID=$(UID) docker-compose up -d
	$(info If you didn't provide a password in docker-compose.yml, then use `docker logs <container>` to see your password)

rstudio-stop:
	docker-compose down

.PHONY: fetch-rawdata
.PHONY: analysis workflow-test 
.PHONY: gh-pages gh-pages-origin
.PHONY: report clean-report 
.PHONY: website clean-website
.PHONY: webpages
.PHONY: rstudio-start rstudio-stop
