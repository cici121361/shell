config_location  = /root/.jupyter/jupyter_lab_config.py
echo c.ServerApp.ip='*' >> config_location
echo c.NotebookApp.open_browser = False >> config_location
echo c.ServerApp.port =8890 >> config_location

echo "#******************Part2:Install_nginx********************#"
# sudo apt install software-properties-common  #already install
sudo add-apt-repository ppa:certbot/certbot
sudo apt install python-certbot-nginx

echo "install certbot"
sudo certbot --nginx


 


