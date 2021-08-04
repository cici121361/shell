# Automatic Installation
echo "Welcome to use Cici's Automatic Install Script! It is easy to configure the JupyterLab environment by this way."

echo "Step1 Update APT"
sudo apt update

echo "Step2 Install Python"
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.9

echo "Also, install setuptools to config python"
sudo apt install python3-pip
pip3 install setuptools>=40.0.0

sudo in -s /usr/bin/python3.9 /usr/bin/python
sudo in -s /usr/bin/python3.9 /usr/bin/python

#check out python version
echo "python version:"
python --version
echo "python3 version"
python3 --version

echo "Step3 Install Python virtualenv"
pip3 install virtualenv

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

#add the needing content into config file
echo c.ServerApp.ip='*' >> config_location
echo c.NotebookApp.open_browser = False >> config_location
echo c.ServerApp.port =8890 >> config_location

#test jupyterlab
jupyter lab

#shut down virtual environment
echo "shut down the virtual environment"
deactivate
