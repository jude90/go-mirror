FROM golang
MAINTAINER zern
USER  root
RUN apt-get update && \
 apt-get install -y tzdata git make && \
 rm -rf /var/lib/apt/lists/* && \
 echo Asia/Shanghai > /etc/timezone && \
 ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
 rm -rf /var/lib/apt/lists/*

RUN mkdir -p $GOPATH/src/github.com/cosmos && \
   cd $GOPATH/src/github.com/cosmos && \
   git clone https://github.com/cosmos/cosmos-sdk.git && \
   cd cosmos-sdk && \
   make tools && \
   make get_vendor_deps && \
   make build && \
   make install && \
   make install_examples && \ 
   make install_cosmos-sdk-cli
