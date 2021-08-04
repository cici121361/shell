echo "Step2 Install Python"
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.9

echo "Also, install setuptools to config python"
sudo pip install --upgrade pip
pip install setuptools>=40.0.0

sudo in -s /usr/bin/python3.9 /usr/bin/python
sudo in -s /usr/bin/python3.9 /usr/bin/python

#check out python version
echo "python version:"
python --version
echo "python3 version"
python3 --version

