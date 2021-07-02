FROM debian:stable

MAINTAINER The HDF-EOS Tools and Information Center <eoshelp@hdfgroup.org>

ENV HOME /root

RUN apt-get update
RUN apt-get -yq install gcc \
                        build-essential \
                        wget \
                        bzip2 \
                        tar \
                        libghc-zlib-dev \
                        libjpeg-dev \
                        gfortran \
                        bison \
                        flex \
                        file

#Build HDF4
RUN wget https://observer.gsfc.nasa.gov/ftp/edhs/hdfeos/latest_release/hdf-4.2.13.tar.gz; \
    tar zxvf hdf-4.2.13.tar.gz; \
    cd hdf-4.2.13; \
    ./configure --prefix=/usr/local/; \
    make && make install; \
    cd ..; \
    rm -rf /hdf-4.2.13 /hdf-4.2.13.tar.gz 

#Build HDF-EOS2
RUN wget https://observer.gsfc.nasa.gov/ftp/edhs/hdfeos/latest_release/HDF-EOS2.20v1.00.tar.Z; \
    tar zxvf HDF-EOS2.20v1.00.tar.Z; \
    cd hdfeos; \
    ./configure --prefix=/usr/local/ --enable-install-include --with-hdf4=/usr/local; \
    make && make install; \
    cd ..; \
    rm -rf /hdfeos /HDF-EOS2.20v1.00.tar.Z 

#Build HDF5
RUN wget https://observer.gsfc.nasa.gov/ftp/edhs/hdfeos5/latest_release/hdf5-1.8.19.tar.gz; \
    tar zxvf hdf5-1.8.19.tar.gz; \
    cd hdf5-1.8.19; \
    ./configure --prefix=/usr/local/ --with-default-api-version=v16; \
    make && make install; \
    cd ..; \
    rm -rf /hd5f-1.8.19 /hdf5-1.8.19.tar.gz 
    
#Build HDF-EOS5
RUN wget https://observer.gsfc.nasa.gov/ftp/edhs/hdfeos5/latest_release/HDF-EOS5.1.16.tar.Z; \
    tar zxvf HDF-EOS5.1.16.tar.Z; \
    cd hdfeos5; \
    ./configure --prefix=/usr/local/ --enable-install-include --with-hdf5=/usr/local; \
    make && make install; \
    cd ..; \
    rm -rf /hdfeos5 /HDF-EOS5.1.16.tar.Z 
