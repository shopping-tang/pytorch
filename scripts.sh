#!/bin/bash

function install() {
	wget https://download.pytorch.org/libtorch/cpu/libtorch-shared-with-deps-1.3.1%2Bcpu.zip
	unzip libtorch-shared-with-deps-1.3.1+cpu.zip
	rm -rf libtorch-shared-with-deps-1.3.1+cpu.zip
}

function build() {
	rm -rf build
	mkdir build
	cd build
	cmake -DCMAKE_PREFIX_PATH=$(dirname $(pwd))/libtorch ..
	make
}

function lint() {
	cpplint --linelength=120 --recursive \
		--filter=-build/include_subdir,-build/include_what_you_use \
		--exclude=tutorials/advanced/utils/include/external/* main.cpp tutorials/*/*/**
}

function lintci() {
	python cpplint.py --linelength=120 --recursive \
		--filter=-build/include_subdir,-build/include_what_you_use \
		--exclude=tutorials/advanced/utils/include/external/* main.cpp tutorials/*/*/**
}

if [ $1 = "install" ]
then
	install
elif [ $1 = "build" ]
then
	build
elif [ $1 = "lint" ]
then
	lint
elif [ $1 = "lintci" ]
then
	lintci
fi