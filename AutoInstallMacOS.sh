# Script installs miniconda and vs code 
# Welcome text 

echo "Welcome to the MacOS Auto Installer Script"
echo "This script will install miniconda and Visual Studio Code on your MacOS"
echo "Please don't close the terminal until the installation is complete"
# Do you want to continue?
read -p "Do you want to continue? (y/n): " choice

# First install homebrew 
echo "Installing Homebrew. Please following the intructions on the screen"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Set environment variables
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
eval "$(/opt/homebrew/bin/brew shellenv)"

# update terminal 
hash -r 

# if homebrew is installed correctly proceed, otherwise exit
if brew help > /dev/null; then
    echo "Homebrew installed successfully"
else
    echo "Homebrew installation failed. Exiting"
    exit 1
fi

# Install miniconda
# Check if miniconda is installed

if conda --version > /dev/null; then
    echo "Miniconda or anaconda is already installed"
else
    echo "Installing Miniconda"
    brew install --cask miniconda
fi

# check if vs code is installed
# using multipleVersionsMac to check 

# if output is empty, then install vs code
if /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/dtudk/pythonsupport-scripts/main/multipleVersionsMac.sh)" > /dev/null; then
    echo "Visual Studio Code is already installed"
else
    echo "Installing Visual Studio Code"
    brew install --cask visual-studio-code
fi

hash -r 

# install extensions for vs code
# install python extension, jupyter, vscode-pdf

code --install-extension ms-python.python
code --install-extension ms-toolsai.jupyter
code --install-extension tomoki1207.pdf

hash -r 

# Finally downgrade python version of base environment to 3.11
conda install python=3.11
