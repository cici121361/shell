# Automatic Installation
echo "Welcome to use Cici's Automatic Install Script! It is easy to configure the JupyterLab environment by this way."
echo "Please make sure you enter this shell in the bottom path"

echo "#******************Part1:InstallPython********************#"
echo "In the part, we will install python and configure jupyter lab in the virtual environment. "
echo "###########Step1 Update APT###########"
sudo apt update && sudo apt full-upgrade

echo "###########Step2 Install Python###########"
echo "+++++++++++++++++++++++++"
echo "install software-properties-common"
sudo apt install software-properties-common

echo "+++++++++++++++++++++++++"
echo "Add-apt-repository ppa:deadsnakes/ppa"
sudo add-apt-repository ppa:deadsnakes/ppa

echo "+++++++++++++++++++++++++"
echo "install python3.9"
sudo apt install python3.9

echo "+++++++++++++++++++++++++"
echo "Also, install setuptools to config python"
sudo apt install python3-pip
pip3 install setuptools>=40.0.0

sudo ln -s /usr/bin/python3.9 /usr/bin/python
sudo ln -s /usr/bin/python3.9 /usr/bin/python3

#check out python version
echo "python version:"
python --version
echo "python3 version"
python3 --version

echo "###########Step3 Create Jupyter Lab virtualenv###########"
echo "install venv"
pip3 install virtualenv

echo "+++++++++++++++++++++++++"
echo"load venv"
echo "input filename to save virtual environment"
read filename

mkdir $filename
cd $filename
echo "entitle the name of this virtual environment to save the virtual environment"
read envname
virtualenv $envname       #creat virtual environment
cd $envname
source bin/activate

echo "+++++++++++++++++++++++++"
echo "Install Jupyter Lab in virtual environment"
pip3 install jupyterlab -i https://pypi.tuna.tsinghua.edu.cn/simple/ #use the mirror provided by Tsinghua University
jupyter lab --generate-config

#set a password
echo "###########Step4 Configure jupyter lab###########"
# echo "set a password to enter jupyter lab in the website"
# apt install ipython
# ipython
# from notebook.auth import passwd
# passwd()

# exit()

# revise config file
# echo "the location of configuration file path:"
# whereis jupyter_lab_config
config_location  = /root/.jupyter/jupyter_lab_config.py
# echo "check out the location of configuration file is $config_location ?Y/n"
# read judge
# case $judge in
#     Y|y) pass;;
#     N|n)echo "input the correct location:"
#            read config_location;;
# esac

#add the needing content into config file
# echo "add the necessary information into configuration file"
# echo c.ServerApp.ip='*' >> config_location
# echo c.NotebookApp.open_browser = False >> config_location
# echo c.ServerApp.port =8890 >> config_location

#test jupyterlab
#echo "test whether or not enter jupyter lab fluently"
#jupyter lab

#shut down virtual environment
#echo "if you finish the test , Please input [deactivate] to shut down the virtual environment"
