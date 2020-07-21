FROM jupyterhub/k8s-hub:0.9.1

# add bin path from pip
ENV PATH="/home/jovyan/.local/bin:${PATH}"

RUN mkdir /srv/jupyterhub/data

# install repo2data and scientific database grabbers
RUN python3 -m pip install --upgrade pip && python3 -m pip install --user --no-cache \ 
    repo2data \
    scipy \
    gitpython \
    scikit-learn \
    nilearn>=0.5.2 
