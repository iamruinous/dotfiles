#!/bin/bash

curl -LO https://thoughtbot.github.io/rcm/dist/rcm-1.3.3.tar.gz &&

	sha=$(sha256sum rcm-1.3.3.tar.gz | cut -f1 -d' ') &&
	[ "$sha" = "935524456f2291afa36ef815e68f1ab4a37a4ed6f0f144b7de7fb270733e13af" ] &&

	tar -xvf rcm-1.3.3.tar.gz &&
	cd rcm-1.3.3 &&

	./configure && \
	make && \
	sudo make install && \
	rm -rf rcm-1.3.3 rcm-1.3.3.tar.gz
