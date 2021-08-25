#! /bin/bash

# Plat:     linux-64
# Function: install python and jupyterlab and configure nginx in server.

this_dir=$(cd $(dirname $0);pwd)

prefix=$HOME/jupyterlab

#https://github.com/wulabing/Xray_onekey/blob/main/install.sh
function python_install(){
	if ! command --version python3.8 >/dev/null 2>&1; then
	  sudo apt install python3.8
	  ln -s /usr/bin/python3.8 /usr/bin/python
}

function jupyterlab_install(){
	if ! command --version jupyter lab >/dev/null 2>&1; then
	  sudo pip install jupyterlab
}

function jupyterlab_deploy(){
	echo "set a password to enter jupyter lab in the website"
	sudo apt install ipython
	ipython << passwords
      from notebook.auth import passwd
      passwd() #a=passwd(),but variables a cannot use in global environment.
      quit()
passwords
	config_location=/root/.jupyter/jupyter_lab_config.py
	read -rp "请输入密码：" passstr
	config_inf="c.ServerApp.ip='*'\n c.NotebookApp.open_browser = False \n c.ServerApp.port =8890 \n c.ServerApp.password =$passstr"
	echo "add the necessary information into configuration file"
	echo $config_inf >> $config_location

}
function port_exist_check() {
  if [[ 0 -eq $(lsof -i:"$1" | grep -i -c "listen") ]]; then
    printf "$1 端口未被占用"
    sleep 1
  else
    printf "检测到 $1 端口被占用，以下为 $1 端口占用信息"
    lsof -i:"$1"
    printf "5s 后将尝试自动 kill 占用进程"
    sleep 5
    lsof -i:"$1" | awk '{print $2}' | grep -v "PID" | xargs kill -9
    printf "kill 完成"
    sleep 1
  fi
}

function nginx_install(){
	if ! command -v nginx >/dev/null 2>&1; then
	  sudo add-apt-repository ppa:certbot/certbot
	  sudo apt install python-certbot-nginx
	else
	  echo "Nginx already exists!"
	fi
}

function certbot_install(){
	if ! command --version certbot >/dev/null 2>&1; then
	  sudo add-apt-repository ppa:certbot/certbot
	  sudo apt install python-certbot-nginx
	else
	  echo "cerbot already exists!"
	fi
}

menu(){
	echo -e "Welcome to use Cici's Automatic Install Script! It is easy to configure the JupyterLab environment by this way."
	echo -e "---------Part1:InstallPython-------------"
	sudo apt update
	sudo apt install software-properties-common
	sudo add-apt-repository ppa:deadsnakes/ppa
	echo "======install python3.8======"
	python_install
	echo "======install jupyterlab======"
	jupyterlab_install
	echo "======deploy jupyterlab======"
	jupyterlab_deploy
	echo "======deploy nginx======"
	port_exist_check 80
	nginx_install
	echo "======deploy certbot======"
	certbot_install
	echo "=======check domain====="
	domain_check
	sudo certbot --nginx
}


