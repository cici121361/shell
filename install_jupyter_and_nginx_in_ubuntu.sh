# Automatic Installation

echo "Welcome to use Cici's Automatic Install Script! It is easy to configure the JupyterLab environment by this way."

# echo "First,please input the location where save the private key:"
# read location
# echo "please input the user name and the domain which provided by AWS platform in the format of [user name]@[domain]"
# read server
# ssh -i $loaction $server

#echo "Obtaining administrator Permissions"
#sudo su root

echo "Step1 Update APT"
sudo apt update

echo "Step2 Install Python"
sudo apt install python-pip python-dev
sudo apt install python3.9
pip install setuptools>=40.0.0

sudo in -s /usr/bin/python3.9 /usr/bin/python
sudo in -s /usr/bin/python3.9 /usr/bin/python

#check out python version
echo "python version:"
python --version
echo "python3 version"
python3 --version

echo "Step3 Install Python virtualenv"
sudo -H pip3 install --upgrade pip
sudo -H pip3 install virtualenv

echo "Step4 Create Python Virtual Evironment"
mkdir env
cd env
virtualenv jupyterlab       #creat virtual environment
source env/jupyterlab/bin/activate

echo "Step5 Install Jupyter Lab in virtual environment"
pip install jupyter lab
jupyter lab --generate-config

#set a password
echo "Step6 Set a password to enter jupyter lab"
jupyter lab password

#revise config file
config_location  = /root/.jupyter/jupyter_lab_config.py
# echo "Whether the location of jupyter lab config is $config_location?Y/N"
# read response
# case $response in
# N|n)echo "input the correct location"
# read config_location ;;
# *)echo "Continuing......";;
# esac

#add the needing content into config file
echo c.ServerApp.ip='*' >> config_location
echo c.NotebookApp.open_browser = False >> config_location
echo c.ServerApp.port =8890 >> config_location

#test jupyterlab
jupyter lab

#shut down virtual environment
echo "shut down the virtual environment"
deactivate



#******************Stage2:Install_nginx********************#
echo "#******************Stage2:Install_nginx********************#"
sudo apt-get update
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install python-certbot-nginx

echo "install certbot"
sudo certbot --nginx

 


