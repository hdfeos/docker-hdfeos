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
    tar zxvf HDF-EOS2.19v1.00.tar.Z; \
    cd hdfeos; \
    ./configure --prefix=/usr/local/ --enable-install-include --with-hdf4=/usr/local; \
    make && make install; \
    cd ..; \
    rm -rf /hdfeos /HDF-EOS2.19v1.00.tar.Z 

#Build HDF5
RUN wget ftp://edhs1.gsfc.nasa.gov/edhs/hdfeos5/latest_release/hdf5-1.8.12.tar.gz; \
    tar xjvf hdf5-1.8.12.tar.gz; \
    cd hdf5-1.8.12; \
    ./configure --prefix=/usr/local/; \
    make && make install; \
    cd ..; \
    rm -rf /hd5f-1.8.12 /hdf5-1.8.12.tar.gz 
    
#Build HDF-EOS5
RUN wget ftp://edhs1.gsfc.nasa.gov/edhs/hdfeos5/latest_release/HDF-EOS5.1.15.tar.Z; \
    tar zxvf HDF-EOS5.1.15.tar.Z; \
    cd hdfeos; \
    ./configure --prefix=/usr/local/ --enable-install-include --with-hdf5=/usr/local; \
    make && make install; \
    cd ..; \
    rm -rf /hdfeos5 /HDF-EOS5.1.15.tar.Z 
