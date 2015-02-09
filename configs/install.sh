#!/bin/bash
echo "checking nim..."
if [ ! -d /opt/nim ]; then
    sudo mkdir -p /opt/nim
    sudo chown irocha: /opt/nim
fi
cd /opt/nim
echo "checking Nim..."
if [ ! -d /opt/nim/Nim ]; then
    echo "building and deploying nim..."
    git clone -b master https://github.com/Araq/Nim.git
    cd ~/git
    ln -s /opt/nim/Nim
    cd /opt/nim/Nim
    git clone -b master --depth 1 https://github.com/nim-lang/csources
    cd csources && sh build.sh
    cd ..
    bin/nim c koch
    ./koch boot
    sudo ln -s /opt/nim/Nim/bin/nim /usr/bin/nim
    ./koch web
fi
echo "checking vim..."
if [ ! -d /opt/nim/nimrod.vim ]; then
    echo "setting up vim..."
    cd /opt/nim
    git clone https://github.com/zah/nimrod.vim.git
    cd ~/git
    ln -s /opt/nim/nimrod.vim
    mkdir -p ~/.vim/autoload ~/.vim/bundle
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    cd ~/.vim/bundle
    ln -s /opt/nim/nimrod.vim
    cd
    rm -rf .vimrc; ln -s ~/nim/configs/.vimrc
    rm -rf .bashrc; ln -s ~/nim/configs/.bashrc
fi

