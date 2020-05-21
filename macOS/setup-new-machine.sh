#!/bin/bash

EMAIL = $1


# Set up new keypair
if [ -z "$EMAIL" ]
then
      ssh-keygen -t rsa -b 4096
else
      ssh-keygen -t rsa -b 4096 -C $EMAIL
fi


# Install zsh 
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install packages
brew install curl awscli emacs docker terraform kubectl
