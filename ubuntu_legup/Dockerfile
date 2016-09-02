FROM ubuntu:14.04
MAINTAINER Pedro Bruel <phrb@ime.usp.br>

WORKDIR /root

# Initial Setup
RUN sudo dpkg --add-architecture i386

RUN apt-get update && apt-get install -y git tcl8.5-dev dejagnu expect \
texinfo build-essential liblpsolve55-dev libgmp3-dev automake libtool clang-3.5 \
libmysqlclient-dev qemu-system-arm qemu-system-mips gcc-4.8-plugin-dev \
libc6-dev meld libqt4-dev libgraphviz-dev libfreetype6-dev \
buildbot-slave libXi6 libpng12-dev libfreetype6-dev \
libfontconfig1 libxft2 libncurses5 libsm6 libxtst6 \
vim gitk kdiff3 libgd-dev openssh-server mysql-server \
python3-mysql.connector python3-serial python3-pyqt5 wget \
libc6-dev-i386 gcc-multilib g++-multilib lib32z1 lib32stdc++6 lib32gcc1 \
expat:i386 fontconfig:i386 libfreetype6:i386 libexpat1:i386 libc6:i386 \
libgtk-3-0:i386 libcanberra0:i386 libpng12-0:i386 libice6:i386 libsm6:i386 \
libncurses5:i386 zlib1g:i386 libx11-6:i386 libxau6:i386 libxdmcp6:i386 \
libxext6:i386 libxft2:i386 libxrender1:i386 libxt6:i386 libxtst6:i386

# Installing GXemul
RUN mkdir gxemul_src && cd gxemul_src && wget http://gxemul.sourceforge.net/src/gxemul-0.6.0.1.tar.gz
RUN cd gxemul_src && tar xvf gxemul-0.6.0.1.tar.gz && cd gxemul-0.6.0.1 && ./configure && make -j6; exit 0
RUN rm /root/gxemul_src/gxemul-0.6.0.1.tar.gz

# Installing LegUp
RUN ln -s /usr/bin/clang-3.5 /usr/bin/clang && mkdir legup_src && cd legup_src && wget http://legup.eecg.utoronto.ca/releases/legup-4.0.tar.gz
# Warning: Make ends with error 2. Altough LegUp seems to be compiled properly,
#                                  you should test if it is.
RUN cd legup_src && tar xvzf legup-4.0.tar.gz && cd legup-4.0 && make -j6; exit 0
RUN rm /root/legup_src/legup-4.0.tar.gz

# Setting PATH for LegUp and GXemul
ENV PATH /root/legup_src/legup-4.0/llvm/Release/bin:/root/gxemul_src/gxemul-0.6.0.1:$PATH

# Setting PATH for Vsim and Quartus
ENV PATH /root/altera_lite/16.0/modelsim_ase/linuxaloem:/root/altera_lite/16.0/quartus/bin:$PATH
