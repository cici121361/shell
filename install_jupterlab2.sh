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
case $pyv in
    "python 3.9"|"python 3.8")echo "the python version is $pyv";;
    *)echo "the python version is $pyv, check out existed python version and update the version if counldn't find."
    if [-z $(dpkg -l | grep python3.9)] || [-z $(dpkg -l | grep python3.8)];then
        sudo pip install python3.9
        ln -s /usr/bin/python3.9 /usr/bin/python
        
        
    ;;
esac


#connection: python/python3 represent which version of python
#install or not: python3.9 / miniconda / nginx




# deploy nginx

nginx_version="1.18.0"
openssl_version="1.1.1k"
zlib_version="1.2.11"
pcre_version="8.44"

nginx_path="/usr/local/nginx"

function checkFile(){
    if [! -f "$1"];then
        echo "$1 is not exited"
        exit 1
    fi
}



