#!/bin/bash
python_install(){
	if !command --version python3.8>/dev/null 2>&1; then
		apt install python3.8
		ln -s /usr/bin/python3.8 /usr/bin/python
	else
		echo "python3.8 already installed."
	fi
}
jupyterlab_install(){
	if ! command --version jupyter lab >/dev/null 2>&1; then
		pip install jupyterlab
		while true
		do 
			echo -n "set a port for jupyterlab:"
			read portnum
			if [ "${#portnum}" -eq "4" -a "$portnum" -le "9999" ]; then
				break
			else
				echo "inappropriate input for port. Please input four-digit number"
			fi
		done
		config_inf="c.ServerAPP.ip='*'\n c.NotebookAPP.apen_brower=False\n c.ServerAPP.port='$portnum'"
		config_location=/home/ubuntu/.jupyter/jupyter_lab.config.py
		cat $config_inf >> $config_location
	else
		echo "jupyterlab already installed."
	fi
	}

port_exist_check(){
	if [ 0 -eq $(lsof -i:"$1" | grep -i -c "listen") ]; then
		printf "port $1 can use."
		sleep 1
	else
		printf "check out port $1 already use. Information is as follow."
		lsof -i:"$1"
		printf "try to kill the occupying process automatically after 10 seconds"
		sleep 10
		lsof -i:"$1" | awk '{print $2}' | grep -v "PID" | kill -9
		printf "finish kill"
		sleep 1
	fi
}

nginx_install(){
	if [ ! command -v nginx >/dev/null 2>&1 -a command --version certbot >/dev/null 2>&1 ]; then
		sudo add-apt repository ppa:certbot/certbot
		apt install python-certbot-nginx
	else
		echo "nginx already install."
	fi
}


menu(){
	echo "Welcome to python installation"
	sudo apt update
	sudo apt install software-properties-common
	sudo add-apt-repository ppa:deadsnakes/ppa

	echo "=======install python3.8=========="
	python_install
	echo "=======install jupyterlab========="
	jupyterlab_install
	echo "=======deploy nginx==============="
	echo -n "the common port used for nginx is 80."
	port_exist_check 80
	echo "=======install nginx=============="
	nginx_install
	sudo certbot --nginx
}

menu
