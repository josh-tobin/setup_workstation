# Setup a new workstation from scratch
# Get up to date
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install tmux build-essential gcc g++ make binutils htop
sudo apt-get -y install software-properties-common
sudo apt-get -y install git
sudo apt-get -y install nvidia-384 nvidia-modprobe

# Anaconda python
mkdir /tmp/conda
wget https://repo.continuum.io/archive/Anaconda3-4.4.0-Linux-x86_64.sh -O /tmp/conda/Anaconda3-4.4.0-Linux-x86_64.sh
bash /tmp/conda/Anaconda3-4.4.0-Linux-x86_64.sh -b -p $HOME/conda
sudo rm -rf /tmp/conda

# Editing environment
sudo apt-get -y install terminator vim
cp .vimrc $HOME/.vimrc
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get -y install sublime-text
cp Preferences.sublime-settings $HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings

# General productivity settings
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"
sudo apt-get install silversearcher-ag
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg –i google-chrome-stable_current_amd64.deb
sudo apt-get install -f
rm google-chrome-stable_current_amd64.deb

# Docker
sudo apt-get update
sudo apt-get -y install \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get -y install docker-ce

# CUDA
mkdir /tmp/cuda
wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb -O /tmp/cuda/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
sudo dpkg -i /tmp/cuda/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
sudo apt-get update
sudo apt-get -y install cuda
sudo rm -rf /tmp/cuda
# CUDNN
CUDNN_TAR_FILE="cudnn-8.0-linux-x64-v6.0.tgz"
wget http://developer.download.nvidia.com/compute/redist/cudnn/v6.0/${CUDNN_TAR_FILE}
tar -xzvf ${CUDNN_TAR_FILE}
sudo cp -P cuda/include/cudnn.h /usr/local/cuda-8.0/include
sudo cp -P cuda/lib64/libcudnn* /usr/local/cuda-8.0/lib64/
sudo chmod a+r /usr/local/cuda-8.0/lib64/libcudnn*

rm ${CUDNN_TAR_FILE}
rm -rf cud

# Tensorflow
sudo apt-get -y install libcupti-dev
pip install tensorflow-gpu

# Finish
cp .bashrc $HOME/.bashrc
source $HOME/.bashrc
sudo reboot
