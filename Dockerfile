# Pull the latest ubuntu and upgrade
FROM ubuntu:latest AS osimage
RUN apt update && apt upgrade -y
FROM osimage AS os


# Install packages needed for build
RUN DEBIAN_FRONTEND="noninteractive" apt install -y autoconf gcc make git libcurl3-openssl-dev libncurses5-dev libtool libjansson-dev libudev-dev libusb-1.0-0-dev pkg-config lib32z1-dev 

# Compile with all parameters
RUN cd /usr/src/ && git clone https://github.com/ckolivas/cgminer.git && cd cgminer \
        && ./autogen.sh \
        && CFLAGS="-O2 -march=native" ./configure \
		--enable-blockerupter \
		--enable-icarus \
		--enable-ants1 \
		--enable-ants2 \      
		--enable-avalon \
		--enable-avalon2 \
		--enable-avalon4 \
		--enable-avalon7 \
		--enable-avalon8 \
		--enable-bab \
		--enable-bflsc \
		--enable-bitforce \
		--enable-bitfury \
		--enable-bitmine_A1 \
		--enable-blockerupter \
		--enable-cointerra \
		--enable-drillbit \
		--enable-hashfast \
		--enable-icarus \
		--enable-klondike \
		--enable-knc \
		--enable-minion \
		--enable-modminer \
		--enable-sp10 \
		--enable-sp30 \
        && make -j$(nproc)

# Remove unnecessary packages
RUN apt remove -y autoconf gcc make git libcurl3-openssl-dev libncurses5-dev libtool libjansson-dev libudev-dev libusb-1.0-0-dev pkg-config lib32z1-dev 
RUN apt autoremove -y
FROM os AS built


# Change directory to the main cgminer directory
WORKDIR /usr/src/cgminer/

# Start mining
ENTRYPOINT ./cgminer -o $POOL_HOST -u $POOL_USER -p $POOL_PASS
