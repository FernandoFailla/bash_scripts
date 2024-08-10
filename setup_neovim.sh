#!/bin/bash

# Atualiza e instala dependências
sudo apt-get update && sudo apt-get install -y \
    sudo \
    git \
    wget \
    curl \
    gnupg \
    software-properties-common \
    build-essential \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    python3-pip \
    python3-dev \
    python3-venv \
    lua5.1 \
    liblua5.1-dev \
    ninja-build \
    gettext \
    libtool \
    libtool-bin \
    autoconf \
    automake \
    cmake \
    g++ \
    nodejs \
    npm \
    pkg-config \
    unzip \ 
    tmux \ 
    libmagickwand-dev \
    firefox-esr

sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*

# Baixa e instala o rig
curl -Ls https://github.com/r-lib/rig/releases/download/v0.7.0/rig-linux-0.7.0.tar.gz | sudo tar xz -C /usr/local
sudo apt update

# Adiciona R
sudo rig add 4.2.2

# Baixa e instala o neovim do repositório
git clone https://github.com/neovim/neovim.git \
    && cd neovim \
    && git checkout stable \
    && make CMAKE_BUILD_TYPE=Release \
    && sudo make install \
    && cd .. \
    && rm -rf neovim

# Baixa dot file de configuração do nvim
git clone https://github.com/jmbuhr/quarto-nvim-kickstarter.git ~/.config/nvim

# Baixa e instala pacotes para R
sudo Rscript -e 'install.packages("pak", repos = sprintf("https://r-lib.github.io/p/pak/stable/%s/%s/%s", .Platform$pkgType, R.Version()$os, R.Version()$arch))'
sudo Rscript -e 'pak::lockfile_create(c("tidyverse","tidymodels","data.table","languageserver"))'

# Instala mais dependências
sudo apt-get update && sudo apt-get install -y \
    texlive-full \
    luarocks \
    libreadline-dev \
    luarocks

sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*

# Instala Node.js 18+ usando nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && /bin/bash -c "source $HOME/.nvm/nvm.sh && nvm install 18 && nvm use 18 && nvm alias default 18"

# Instala pacotes R usando pak
sudo Rscript -e "pak::lockfile_install()"

# Instalação do Quarto Markdown
curl -L https://github.com/quarto-dev/quarto-cli/releases/download/v1.6.3/quarto-1.6.3-linux-amd64.deb -o quarto.deb
sudo dpkg -i quarto.deb
rm quarto.deb

# Instalação do Miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
bash miniconda.sh -b -p $HOME/miniconda
source $HOME/miniconda/bin/activate
conda init
conda update -y conda
conda config --add channels conda-forge
