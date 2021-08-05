#revise config file
echo "the location of configuration file path:"
whereis jupyter_lab_config
config_location  = /root/.jupyter/jupyter_lab_config.py
echo "check out the location of configuration file is $config_location ?Y/n"
read judge
case $judge in
     Y|y) echo "continue to enter the later step";;
     N|n)echo "input the correct location:"
            read config_location;;
esac

#add the needing content into config file
echo "add the necessary information into configuration file"
echo "input the str which represents the password"
read password
echo c.ServerAPP.password = u$password >> config_location
echo c.ServerApp.ip='*' >> config_location
echo c.NotebookApp.open_browser = False >> config_location
echo c.ServerApp.port =8890 >> config_location

#test jupyterlab
echo "test whether or not enter jupyter lab fluently"
jupyter lab

#shut down virtual environment
echo "if you finish the test , Please input [deactivate] to shut down the virtual environment"
