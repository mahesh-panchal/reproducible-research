# Makefile for the Gitpod Environment. TODO: Add a script for ./configure

# CONDA_PKGM := mamba                  # Conda package manager to use
DISTILL_IMG := rocker/distill:4.1.2  # Image name and version
WEBSITE_DIR := website
# Replace Container command with Singularity, or other container engine
# Initialise to empty string along with DISTILL_IMG to use local R installation
UID := $$( id -u )
GROUP := $$( id -g )
CONTAINER_CMD := docker run --user "$(UID):$(GROUP)" --rm -v "${PWD}:/home/rstudio" -w /home/rstudio

# Run Nextflow workflow
analysis:
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
	$(CONTAINER_CMD) $(DISTILL_IMG) Rscript scripts/build_report.R

clean-report:

# Build the Rocker Distill container for making the website and reports
rocker-distill:
	scripts/build_distill_container.sh $(DISTILL_IMG)

# Publish Distill website to local gh-pages branch
gh-pages: $(WEBSITE_DIR)/docs/index.html
	git subtree push --prefix $(WEBSITE_DIR)/docs . gh-pages

# Publish Distill website to gh-pages branch on Github
gh-pages-origin: $(WEBSITE_DIR)/docs/index.html
	git subtree push --prefix $(WEBSITE_DIR)/docs origin gh-pages

# Builds the Distill website
website: $(WEBSITE_DIR)/_site.yml
	$(CONTAINER_CMD) $(DISTILL_IMG) Rscript scripts/build_website.R $(WEBSITE_DIR)

$(WEBSITE_DIR)/_site.yml:
	$(CONTAINER_CMD) $(DISTILL_IMG) Rscript scripts/init_website.R $(WEBSITE_DIR)

clean-website:
	rm -rf $(WEBSITE_DIR)

# Run RStudio from Rocker/verse:4.1.2 using docker-compose
rstudio-start:
	UID=$(UID) docker-compose up -d
	$(info If you didn't provide a password in docker-compose.yml, then use `docker logs <container>` to see your password)

rstudio-stop:
	docker-compose down

.PHONY: analysis gh-pages report rocker-distill website clean-report clean-website rstudio-start rstudio-stop
