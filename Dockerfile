FROM ubuntu:18.04

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

MAINTAINER ISHII 2bit <i@2bit.jp>

COPY config.cfg /tmp/icc-config.cfg
COPY license.lic /tmp/icc-license.lic

RUN apt update --fix-missing && \
    apt upgrade -y && \
    apt install -y vim wget bzip2 ca-certificates curl git cpio build-essential && \
    apt clean

RUN cd /tmp && \
    wget -O icc.tgz http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/14857/parallel_studio_xe_2019_update1_professional_edition_for_cpp_online.tgz && \
    tar -xvzf icc.tgz && \
    cd /tmp/parallel_studio_xe_* && \
    bash ./install.sh --silent=/tmp/icc-config.cfg && \
    cd /tmp && \
    rm -rf parallel_studio_xe_* icc.tgz && \
    rm /tmp/icc-config.cfg

 RUN echo "source /opt/intel/parallel_studio_xe_2019/compilers_and_libraries_2019/linux/pkg_bin/compilervars.sh -arch intel64 && source /opt/intel/parallel_studio_xe_2019/compilers_and_libraries_2019/linux/mkl/bin/mklvars.sh intel64" >> ~/.bashrc
