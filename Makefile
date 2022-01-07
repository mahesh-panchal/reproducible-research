# Makefile for the Gitpod Environment. TODO: Add a script for ./configure

# CONDA_PKGM := mamba                  # Conda package manager to use
DISTILL_IMG := rocker/distill:4.1.2  # Image name and version
WEBSITE_DIR := website_src
# Replace Container command with Singularity, or other container engine
# Initialise to empty string along with DISTILL_IMG to use local R installation
CONTAINER_CMD := docker run --user "${UID}:${GROUPS}" --rm -v "${PWD}:/home/rstudio" -w /home/rstudio

# Run Nextflow workflow
analysis:

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

# Builds the Distill website
website: $(WEBSITE_DIR)/_site.yml
	cd $(WEBSITE_DIR); \
	$(CONTAINER_CMD) $(DISTILL_IMG) Rscript scripts/build_website.R

$(WEBSITE_DIR)/_site.yml:
	$(CONTAINER_CMD) $(DISTILL_IMG) Rscript scripts/init_website.R $(WEBSITE_DIR)

clean-website:
	rm -rf $(WEBSITE_DIR)

.PHONY: analysis report rocker-distill website clean-report clean-website
