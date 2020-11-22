# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD:=$(shell pwd)


all: clean
	mkdir --parents $(PWD)/build
	mkdir --parents $(PWD)/build/AppDir
	mkdir --parents $(PWD)/build/AppDir/mattermost
	

	wget --output-document="$(PWD)/build/build.tar.gz" "https://releases.mattermost.com/desktop/4.3.1/mattermost-desktop-4.3.1-linux-x64.tar.gz"
	tar -zxvf $(PWD)/build/build.tar.gz -C $(PWD)/build

	wget --no-check-certificate --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/gtk3-3.22.30-5.el8.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --no-check-certificate --output-document=$(PWD)/build/build.rpm https://ftp.lysator.liu.se/pub/opensuse/distribution/leap/15.2/repo/oss/x86_64/libatk-1_0-0-2.34.1-lp152.1.7.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --no-check-certificate --output-document=$(PWD)/build/build.rpm https://ftp.lysator.liu.se/pub/opensuse/distribution/leap/15.2/repo/oss/x86_64/libatk-bridge-2_0-0-2.34.1-lp152.1.5.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --no-check-certificate --output-document=$(PWD)/build/build.rpm https://ftp.lysator.liu.se/pub/opensuse/distribution/leap/15.2/repo/oss/x86_64/libatspi0-2.34.0-lp152.2.4.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..
		
	cp --force --recursive $(PWD)/build/mattermost-*/* $(PWD)/build/AppDir/mattermost
	cp --force --recursive $(PWD)/build/usr/* $(PWD)/build/AppDir/
	cp --force --recursive $(PWD)/AppDir/* $(PWD)/build/AppDir

	chmod +x $(PWD)/build/AppDir/AppRun
	chmod +x $(PWD)/build/AppDir/*.desktop

	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage $(PWD)/build/AppDir $(PWD)/Mattermost.AppImage
	chmod +x $(PWD)/Mattermost.AppImage


clean:
	rm -rf $(PWD)/build
