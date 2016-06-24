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

# Installing Quartus
# From the Internet
RUN mkdir quartus_src && cd quartus_src && wget http://download.altera.com/akdlm/software/acdsinst/16.0/211/ib_tar/Quartus-lite-16.0.0.211-linux.tar
RUN cd quartus_src && tar xvf Quartus-web-13.0.1.232-linux.tar && rm Quartus-web-13.0.1.232-linux.tar

# Using a Local Copy
# WARNING: EXTREMELY DISK IO INTENSIVE
#RUN mkdir quartus_src
#ADD Quartus-lite-16.0.0.211-linux.tar ./quartus_src

# Run install script
ADD install_quartus.exp ./quartus_src
RUN cd quartus_src && chmod +x install_quartus.exp && ./install_quartus.exp

# Setup Quartus Libraries
RUN ln -s /root/altera_lite/16.0/quartus/linux64/* /usr/lib/; exit 0

# Setting PATH for Vsim and Quartus
ENV PATH /root/altera_lite/16.0/modelsim_ase/linuxaloem:/root/altera_lite/16.0/quartus/bin:$PATH
