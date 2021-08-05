sudo ln -s /usr/bin/python3.9 /usr/bin/python
sudo ln -s /usr/bin/python3.9 /usr/bin/python

#check out python version
echo "python version:"
python --version
echo "python3 version"
python3 --version

echo "###########Step3 Create Jupyter Lab virtualenv###########"
echo "install venv"
pip3 install virtualenv

echo "+++++++++++++++++++++++++"
echo"load venv in the location of /env/jupyterlab"
mkdir cicienv
cd cicienv
virtualenv jupyterlab       #creat virtual environment
source jupyterlab/bin/activate

echo "+++++++++++++++++++++++++"
echo "Install Jupyter Lab in virtual environment"
pip3 install jupyter lab -i https://pypi.tuna.tsinghua.edu.cn/simple/ #use the mirror provided by Tsinghua University
jupyter lab --generate-config

#set a password
echo "###########Step4 Configure jupyter lab###########"
echo "set a password to enter jupyter lab in the website"
apt install ipython
ipython
from notebook.auth import passwd
passwd()

exit()

#revise config file
echo "the location of configuration file path:"
whereis jupyter_lab_config
config_location  = /root/.jupyter/jupyter_lab_config.py
echo "check out the location of configuration file is $config_location ?Y/n"
read judge
case $judge in
     Y|y) echo "enter the later step" ;;
     N|n)echo "input the correct location:"
            read config_location;;
esac

#add the needing content into config file
echo "add the necessary information into configuration file"
echo "input the str which represents password."
read password
echo c.ServerAPP.password=u$password
echo c.ServerApp.ip='*' >> config_location
echo c.NotebookApp.open_browser = False >> config_location
echo c.ServerApp.port =8890 >> config_location

#test jupyterlab
echo "test whether or not enter jupyter lab fluently"
jupyter lab

#shut down virtual environment
echo "if you finish the test , Please input [deactivate] to shut down the virtual environment"
