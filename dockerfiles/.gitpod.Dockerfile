FROM gitpod/workspace-full:latest

WORKDIR /opt

# Install R
RUN sudo apt-get update --fix-missing && \
    sudo apt-get install -y \
        r-base \
        r-base-dev

# Install Julia
# This takes a long time to install into the build.
RUN brew install julia
# RUN wget https://julialang-s3.julialang.org/bin/linux/x64/1.8/julia-1.8.1-linux-x86_64.tar.gz && \
#     tar zxvf julia-1.8.1-linux-x86_64.tar.gz
# ENV PATH="$PATH:/opt/julia-1.8.1/bin"

# Install Nextflow
RUN curl -s https://get.nextflow.io | bash && \
    mv nextflow /usr/local/bin

# Install Quarto
RUN wget https://quarto.org/download/latest/quarto-linux-amd64.deb && \
    # apt-get install gdebi-core && \
    sudo dpkg -i quarto-linux-amd64.deb && \
    rm quarto-linux-amd64.deb && \
    quarto check all
