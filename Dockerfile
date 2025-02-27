FROM kasmweb/core-ubuntu-focal:1.15.0

USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

# Install dependencies
RUN apt-get update && apt-get install -y \
    g++ \
    python3 \
    cmake \
    ninja-build \
    git \
    gir1.2-goocanvas-2.0 \
    python3-gi \
    python3-gi-cairo \
    python3-pygraphviz \
    gir1.2-gtk-3.0 \
    ipython3 \
    tcpdump \
    wireshark \
    sqlite \
    sqlite3 \
    libsqlite3-dev \
    qtbase5-dev \
    qtchooser \
    qt5-qmake \
    qtbase5-dev-tools \
    openmpi-bin \
    openmpi-common \
    openmpi-doc \
    libopenmpi-dev \
    doxygen \
    graphviz \
    imagemagick \
    python3-sphinx \
    dia \
    texlive \
    dvipng \
    latexmk \
    texlive-extra-utils \
    texlive-latex-extra \
    texlive-font-utils \
    libeigen3-dev \
    gsl-bin \
    libgsl-dev \
    libgslcblas0 \
    libxml2 \
    libxml2-dev \
    libgtk-3-dev \
    lxc-utils \
    lxc-templates \
    vtun \
    uml-utilities \
    ebtables \
    bridge-utils \
    libboost-all-dev \
    mercurial \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/kasm-user/Desktop /home/kasm-user/Uploads

# Create a file on the desktop
RUN touch $HOME/Desktop/hello.txt

# Download, extract and install ns-3.38 and NetAnim
RUN wget -O $HOME/ns-allinone-3.38.tar.bz2 https://www.nsnam.org/releases/ns-allinone-3.38.tar.bz2 && \
    tar -xjf $HOME/ns-allinone-3.38.tar.bz2 -C $HOME && \
    rm $HOME/ns-allinone-3.38.tar.bz2 && \
    cd $HOME/ns-allinone-3.38 && \
    ./build.py && \
    hg clone http://code.nsnam.org/netanim && \
    cd netanim && \
    qmake NetAnim.pro && \
    make

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000

# Set up environment for ns-3
RUN echo 'export PATH=$HOME/ns-allinone-3.38/bin:$PATH' >> $HOME/.bashrc && \
    echo 'export LD_LIBRARY_PATH=$HOME/ns-allinone-3.38/lib:$LD_LIBRARY_PATH' >> $HOME/.bashrc && \
    echo 'export PYTHONPATH=$HOME/ns-allinone-3.38/lib/python3.8/site-packages:$PYTHONPATH' >> $HOME/.bashrc
