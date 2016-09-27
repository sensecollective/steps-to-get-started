#!/bin/bash

sudo ./sosreport -o collectd --tmp-dir . && \
	sudo chown arcolife:arcolife sosreport-localhost* && \
	rm sosreport-localhost*.md5 && \
	tar xJf sosreport-localhost*.tar.xz  && \
	rm *.tar.xz && echo && \
	cat sosreport-localhost*/sos_reports/sos.txt && \
	egrep 'Password|Host|Port|URL' sosreport-localhost*/etc/*.conf && \
	rm -rf sosreport-localhost* && \
	echo

