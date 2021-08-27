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

# Build HDF4
RUN wget https://support.hdfgroup.org/ftp/HDF/releases/HDF4.2.15/src/hdf-4.2.15.tar.gz; \
    tar zxvf hdf-4.2.15.tar.gz; \
    cd hdf-4.2.15; \
    ./configure --prefix=/usr/local/; \
    make && make install; \
    cd ..; \
    rm -rf /hdf-4.2.15 /hdf-4.2.15.tar.gz 

# Build HDF-EOS2
RUN wget -O hdfeos2.tar.gz "https://git.earthdata.nasa.gov/projects/DAS/repos/hdfeos/raw/hdf-eos2-3.0-src.tar.gz?at=3128a738021501c821549955f6c78348e5f33850"; \
    tar zxvf hdfeos.tar.gz; \
    cd hdf-eos2-3.0; \
    ./configure --prefix=/usr/local/ --enable-install-include --with-hdf4=/usr/local; \
    make && make install; \
    cd ..; \
    rm -rf /hdf-eos2-3.0 /hdfeos.tar.gz 

# Build HDF5
RUN wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.19/src/hdf5-1.8.19.tar.gz; \
    tar zxvf hdf5-1.8.19.tar.gz; \
    cd hdf5-1.8.19; \
    ./configure --prefix=/usr/local/ --with-default-api-version=v16; \
    make && make install; \
    cd ..; \
    rm -rf /hd5f-1.8.19 /hdf5-1.8.19.tar.gz 
    
# Build HDF-EOS5
RUN wget "https://git.earthdata.nasa.gov/rest/git-lfs/storage/DAS/hdfeos5/7054de24b90b6d9533329ef8dc89912c5227c83fb447792103279364e13dd452?response-content-disposition=attachment%3B%20filename%3D%22HDF-EOS5.1.16.tar.Z%22%3B%20filename*%3Dutf-8%27%27HDF-EOS5.1.16.tar.Z"; \
    tar zxvf HDF-EOS5.1.16.tar.Z; \
    cd hdfeos5; \
    ./configure --prefix=/usr/local/ --enable-install-include --with-hdf5=/usr/local; \
    make && make install; \
    cd ..; \
    rm -rf /hdfeos5 /HDF-EOS5.1.16.tar.Z 
