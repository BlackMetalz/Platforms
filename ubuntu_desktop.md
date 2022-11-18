# Software needed for Ubuntu Desktop imo

```
# Sublime text
# https://www.sublimetext.com/docs/linux_repositories.html#apt
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
apt-get update
apt-get install apt-transport-https -y
apt-get install sublime-text -y

# VS Code



```
