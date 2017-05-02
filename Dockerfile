FROM debian:jessie

MAINTAINER The HDF-EOS Tools and Information Center <eoshelp@hdfgroup.org>

ENV HOME /root

RUN apt-get update
RUN apt-get -yq install gcc \
                        build-essential \
                        wget \
                        bzip2 \
                        tar \
                        libghc-zlib-dev

#Build HDF4
RUN wget ftp://edhs1.gsfc.nasa.gov/edhs/hdfeos/latest_release/hdf-4.2.10.tar.gz; \
    tar xjvf hdf-4.2.10.tar.gz; \
    cd hdf-4.2.10; \
    ./configure --prefix=/usr/local/; \
    make && make install; \
    cd ..; \
    rm -rf /hdf-4.2.10 /hdf-4.2.10.tar.gz 

#Build HDF-EOS2
RUN wget ftp://edhs1.gsfc.nasa.gov/edhs/hdfeos/latest_release/HDF-EOS2.19v1.00.tar.Z; \
    tar xjvf HDF-EOS2.19v1.00.tar.Z; \
    cd hdfeos; \
    ./configure --prefix=/usr/local/ --enable-install-include --with-hdf4=/usr/local; \
    make && make install; \
    cd ..; \
    rm -rf /hdfeos /HDF-EOS2.19v1.00.tar.Z 

#Install HDF-EOS5
RUN apt-get hdf-eos5
