#!/bin/bash
echo "-=Install the basics=-"
read -p "Press any key to continue... " -n1 -s
echo  '\n'



echo "Checking Command Line Tools for Xcode..."
# Only run if the tools are not installed yet
# To check that try to print the SDK path
xcode-select -p &> /dev/null
if [ $? -ne 0 ]
then
  echo "Command Line Tools for Xcode not found. Installing from softwareupdate..."
# This temporary file prompts the 'softwareupdate' utility to list the Command Line Tools
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
  PROD=$(softwareupdate -l | grep "\*.*Command Line" | tail -n 1 | sed 's/^[^C]* //')
  softwareupdate -i "$PROD" --verbose;
else
  echo "Command Line Tools for Xcode already installed."
fi


echo "Checking for Homebrew..."
if ! command -v brew &> /dev/null
then
  echo "Not found, Installing Homebrew..."
  /bin/bash -c "$(curl  -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew already installed."
fi


echo "Checking for Oh My ZSH..."
if [ -d ~/.oh-my-zsh ]
then
  echo "oh-my-zsh already installed."
else
  echo "Not found, installing Oh My ZSH..."
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi


echo "Checking for PowerLevel10K zsh theme..."
if [ -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]
then
  echo "PowerLevel10k theme already installed."
else
  echo "Installing Nerd Fonts..."
  cd ~/Library/Fonts && { 
  curl -O 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf'
  curl -O 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf'
  curl -O 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf'
  curl -O 'https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf'
  cd -; }
  echo "Installing Powerlevel10k zsh theme..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
  echo "Installing zsh-syntax-highlighting..."
  brew install zsh-syntax-highlighting
  echo "Installing zsh-autosuggestions..."
  brew install zsh-autosuggestions

fi


echo "Checking for Python 3..."
if ! command -v python3 &> /dev/null
  then
  echo "Not found, Installing Python 3..."
  brew install python
  else
  echo "Python already installed."
fi


echo "Checking for Ansible..."
if ! command -v ansible &> /dev/null
  then
  echo "Not found, Installing Ansible..."
  pip3 install ansible
  else
  echo "Ansible already installed."
fi




