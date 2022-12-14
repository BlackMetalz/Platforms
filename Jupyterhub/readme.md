### Ref: https://jupyterhub.readthedocs.io/en/stable/quickstart.html#installation

#### Install jupyterhub with single port and multiple user based linux user
```
apt install python3-venv 
python3 -m pip install jupyterhub jupyterlab notebook
```

```
##### Start first time
jupyterhub --generate-config 

##### Add config
##### add user with prefix da_username
useradd -m -d /storage/jupyterhub-works/da_username -s /bin/sh da_username
##### Set password for that user
passwd da_username
##### Su to user and help create env for user
su - da_username -s /bin/bash
python3 -m venv env
. env/bin/activate
##### Help user upgrade pip
pip install --upgrade pip
##### instaall ipykernel
pip install ipykernel
##### add kernel to your user
python -m ipykernel install --user --name="da_username" --display-name="da_username"
##### After this, ipykernel will show in current user, show it by:
jupyter kernelspec list
```

## Start server ##
```
##### Create new screen 
screen -S jupyterhub
##### Active env of jupyterhub
. /storage/jupyterhub/env/bin/activate
##### Run following command
jupyterhub -f /storage/jupyterhub/jupyterhub_config.py --ip 0.0.0.0 --port 8000
```
