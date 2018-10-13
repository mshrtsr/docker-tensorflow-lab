FROM tensorflow/tensorflow:latest-gpu-py3

MAINTAINER Masaharu TASHIRO <masatsr.kit@gmail.com>

# Update nodejs & npm
RUN apt-get update && apt-get install -y --no-install-recommends \
    nodejs \
    npm \
 && npm cache clean \
 && npm install n -g \
 && n stable \
 && ln -sf /usr/local/bin/node /usr/bin/node \
 && ln -sf /usr/local/bin/npm /usr/bin/npm \
 && apt-get purge -y \
    nodejs \
    npm \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Install Jupyter Lab
RUN pip install jupyterlab
RUN echo '#!/usr/bin/env bash \n jupyter lab "$@"' > /run_jupyter.sh

# Copy sample notebooks.
COPY notebooks /notebooks

#CMD ["/run_jupyter.sh", "--allow-root"]
    
