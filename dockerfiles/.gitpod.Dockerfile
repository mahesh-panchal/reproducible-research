FROM gitpod/workspace-full:latest

WORKDIR /opt

# Install R
RUN apt-get update --fix-missing && \
    apt-get install -y \
        gdebi-core \
        r-base \
        r-base-dev

# Install Julia
RUN wget https://julialang-s3.julialang.org/bin/linux/x64/1.8/julia-1.8.1-linux-x86_64.tar.gz && \
    tar zxvf julia-1.8.1-linux-x86_64.tar.gz
ENV PATH="$PATH:/opt/julia-1.8.1/bin"

# Install Nextflow
RUN curl -s https://get.nextflow.io | bash && \
    mv nextflow /usr/local/bin

# Install Quarto
RUN wget https://quarto.org/download/latest/quarto-linux-amd64.deb && \
    # apt-get install gdebi-core && \
    gdebi quarto-linux-amd64.deb && \
    rm quarto-linux-amd64.deb && \
    quarto check all


