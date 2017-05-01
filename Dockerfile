FROM debian:wheezy

MAINTAINER John Foster <johntfosterjr@gmail.com>

ENV HOME /root

RUN apt-get update
RUN apt-get -yq install gcc \
                        build-essential \
                        wget \
                        bzip2 \
                        tar \
                        libghc6-zlib-dev

#Build HDF4
RUN wget ftp://edhs1.gsfc.nasa.gov/edhs/hdfeos/latest_release/hdf-4.2.10.tar.gz; \
    tar xjvf hdf-4.2.10.tar.gz; \
    cd hdf-4.2.10; \
    ./configure --prefix=/usr/local/; \
    make && make install; \
    cd ..; \
    rm -rf /hdf-4.2.10 /hdf-4.2.10.tar.gz 

#Build HDF5
RUN wget http://www.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.8.13.tar.bz2; \
    tar xjvf hdf5-1.8.13.tar.bz2; \
    cd hdf5-1.8.13; \
    ./configure --prefix=/usr/local/hdf5; \
    make && make install; \
    cd ..; \
    rm -rf /hdf5-1.8.13 /hdf5-1.8.13.tar.bz2 

#Build HDF-EOS2

#Build HDF-EOS5
