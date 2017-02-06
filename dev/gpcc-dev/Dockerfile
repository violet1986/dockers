FROM golang:1.7.4

RUN mkdir -p /go/src/gpcc
RUN apt-get update && apt-get install -y \
    sudo \
    vim \
    postgresql \
    libkrb5-dev

RUN useradd -ms /bin/bash gpadmin \
    && chown -R gpadmin:gpadmin /go/src/gpcc

RUN echo "root:gpcc" | chpasswd \
    && echo "gpadmin:gpcc" | chpasswd \
    && usermod -aG sudo gpadmin
RUN curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash - \
    && apt-get update &&  apt-get install -y nodejs \
    build-essential
RUN npm install --global gulp@3.9.0
USER gpadmin
VOLUME /go/src/gpcc
WORKDIR /go/src/gpcc
RUN git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it && ~/.bash_it/install.sh >/dev/null \
    && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

ADD vimrc /home/gpadmin/.vimrc
RUN vim +PluginInstall +qall >/dev/null \
    && vim +GoInstallBinaries +qall >/dev/null \
    && go get github.com/tools/godep \
    && go get github.com/onsi/ginkgo/ginkgo \
    && go get github.com/onsi/gomega

ADD env-test.sh /home/gpadmin/env-test.sh


