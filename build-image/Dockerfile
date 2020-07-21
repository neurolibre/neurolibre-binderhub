FROM jupyterhub/repo2docker:master

# add bin path from pip
ENV PATH="/home/jovyan/.local/bin:${PATH}"

RUN mkdir /srv/jupyterhub/data

# install repo2data and other libraries (to pull data from)
RUN python3 -m pip install --upgrade pip && python3 -m pip install --user --no-cache \ 
    repo2data \
    scipy \
    scikit-learn \
    nilearn>=5.2

#need to inject data requirement file here
repo2data --server
