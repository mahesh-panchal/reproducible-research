# Reproducible research demo

A demonstration of how to work reproducibly using version control, containers, notebooks, and a workflow manager.

Visit the [website](https://mahesh-panchal.github.io/reproducible-research/) for how to use the tools demonstrated here.

Play with this demo in Gitpod.

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/mahesh-panchal/reproducible-research)

## About

Communication is a cornerstone of effective science.

The aim of this demo is to show how one can efficiently make a publishable dry-lab notebook, with all the details
necessary to replicate the various computational analyses performed. Importantly, an aim is to reduce the work 
needed to get from code to something published. In this case, the published form is a website that demonstrates
with no ambiguity how you got from the beginning to the end of your project. Unlike a journal article, a website
can go into more detail of the analyses that got you to the novel result without relegating everything to
supplementary material. This kind of publishable notebook can also be a demonstration of the skills you've 
learned along the way, which would otherwise be hidden away (or worse, forgotten about).

This demo aims to lower the barrier as much as possible for computational biologists and bioinformaticians, 
but there is one thing that can not be avoided. That is, comfort with the Unix command line. Knowing how to 
navigate the file system is a fundamental first step in using these tools. 

## Tools

Here is a brief description of the tools I use. See their corresponding webpages in this demo for more details 
([Go to demo website](https://mahesh-panchal.github.io/reproducible-research/)). 

**Version control**: `git` is a tool used for managing file versions that has become ubiquitous. I also use **Github**
to publically host the folder with the managed files, and as a means of hosting the website. 

**Containers**: Installing software can be a pain, and so can sharing software so others can reproduce your work. 
Containerized software can alleviate that. A container designed to run a particular software will have all 
the dependencies necessary to run. There are many container platforms, but here I use the container platform 
**Docker**, and also reference the container platform **Singularity**.

**Notebooks**: These are files where you record how, what and why you are doing something. They intermingle
code and explanation, keeping relevant parts together for easier understanding. The code you use to 
obtain your results can not be misinterpreted. I use **RMarkdown** in this demo, which also allows the notebooks
to be published in various forms such as a website, report, or slide show. 

**Workflow manager**: A workflow manager is used to handle large scale data processing (or even small scale
as demonstrated here). Notebooks are generally limited to processing tables of results, running statistical 
analyses, and producing plots for interpretation. A workflow manager on the other hand can be used to take 
large quantities of data, process them in parallel, and deliver refined tables of results that are easy to 
process in a notebook. **Nextflow** is my favoured workflow manager.

Lastly, this Github repository also enables you to use these tools and play with them at your convenience.
Click on the "Open in Gitpod" button to open an ephmeral computing environment, with both file editor and 
command line terminal to try this for yourself. The following tools are available in this environment:

- git
- Docker
- R and RStudio (via a Docker container)
- Nextflow
