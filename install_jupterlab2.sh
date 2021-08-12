#! /bin/bash

# Plat:     linux-64
# Function: install python and jupyterlab and configure nginx in server.

this_dir=$(cd $(dirname $0);pwd)
this_file=$(basement $0)
this_path="$this_dir/$this_file"
prefix=$HOME/jupyterlab  

#check: the version of python
pyv="$(python -V 2>&1)"
py3v="$(python3 -V 2>&1)"
case "$(python -V 2>&1)" in
    "python 3.9"|"python 3.8")echo "the python version is $pyv";;
    *)echo "the python version is $pyv, check out existed python version and update the version if counldn't find."
    if [-z $(dpkg -l | grep python3.9)] || [-z $(dpkg -l | grep python3.8)];then
        sudo apt update
        sudo apt install software-properties-common
        sudo add-apt-repository ppa:deadsnakes/ppa
        sudo pip install python3.8
        ln -s /usr/bin/python3.8 /usr/bin/python
        if ["$(pip --version)"=~"not found"];then sudo apt install python-pip; fi
    elif [-n $(dpkg -l | grep python3.8)];then
        ln -s /usr/bin/python3.8 /usr/bin/python
    else
        ln -s /usr/bin/python3.9 /usr/bin/python
        if ["$(pip --version)"=~"not found"];then sudo apt install python-pip; fi
        pip3 install setuptools>=40.0.0
    fi
    ;;
esac

#install jupyterlab
if ["$(jupyter lab --version)"=~"not found"];then pip install jupyterlab; fi
echo "set a password to enter jupyter lab in the website"
apt install ipython
ipython << cici
from notebook.auth import passwd
passwd() #a=passwd(),but variables a cannot use in global environment.
quit()
cici

echo "input the str which jupyter output"
read -r passstr
#while true; do
#    case "$passstr" in
        
    

config_location=/root/.jupyter/jupyter_lab_config.py
config_inf="c.ServerApp.ip='*'\n c.NotebookApp.open_browser = False \n c.ServerApp.port =8890 \n c.ServerApp.password =$passstr"
echo "add the necessary information into configuration file"
echo $config_inf >> $config_location

#whether or not install the virtual environment: virualenv / miniconda
#set a password



# deploy nginx
nginx_path="/usr/local/nginx"

if ["$(nginx -V)"=~"not found"];then sudo apt install nginx; fi
sudo add-apt-repository ppa:certbot/certbot
sudo apt install python-certbot-nginx
echo "install certbot"
sudo certbot --nginx



