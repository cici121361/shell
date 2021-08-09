echo "#******************Part2:Install_nginx********************#"
# sudo apt install software-properties-common  #already install
sudo add-apt-repository ppa:certbot/certbot
sudo apt install python-certbot-nginx

echo "install certbot"
sudo certbot --nginx


 


