echo "Step1 Update APT"
sudo apt update

echo "Step2 Install Python"
sudo apt install python3-pip python3-dev
sudo apt install python3.9
pip install setuptools>=40.0.0
