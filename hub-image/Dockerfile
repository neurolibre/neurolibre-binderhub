FROM jupyterhub/k8s-hub:0.11.1-n128.h35ca170e

# add bin path from pip
ENV PATH="/home/jovyan/.local/bin:${PATH}"

RUN mkdir /srv/jupyterhub/data

# install repo2data and scientific database grabbers
RUN python3 -m pip install --upgrade pip && python3 -m pip install --user --no-cache \ 
    repo2data==2.1 \
    scipy==1.5.1 \
    GitPython==3.1.11 \
    scikit-learn==0.23.1 \
    nilearn>=0.5.2 \
    jupyter-book==0.10.1 
