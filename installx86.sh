#!/bin/bash
cd /root
apt-get update
apt-get -y upgrade
apt-get -y autoremove
apt-get -y install build-essential bison git curl
mkdir /root/go
export GOPATH=/root/go
export PATH=$PATH:/root/go/bin
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
source /root/.gvm/scripts/gvm
gvm install go1.8 -B -pb
gvm use go1.8 --default
mkdir $GOPATH/bin
go get -u github.com/Masterminds/glide
go get -u github.com/tendermint/tendermint/...
cd $GOPATH/src/github.com/tendermint/tendermint
git branch develop
make install
go get -u github.com/dawn-network/glogchain/...
cd $GOPATH/src/github.com/dawn-network/glogchain
git branch develop
cd $GOPATH/src/github.com/dawn-network/glogchain
glide install
go build .
go install .
go get github.com/ipfs/go-ipfs
cd $GOPATH/src/github.com/ipfs/go-ipfs
make install
cd ~/
ipfs init
ipfs cat /ipfs/QmVLDAhCY3X9P2uRudKAryuQFPM5zqA3Yij1dY8FpGbL7T/readme
tendermint init
echo "Please ensure that you have set up any needed forwarding.  This script detects your public IP address, but there are many good reasons why your machine may not be using a public IP address.  We've no love for NAT, so if you're running a validator, we do expect that you'll be able to use the forwarding features on your router.
