PREFIX ?= /usr/local

install: install-script install-service enable-service

install-dcmi-power: install-script-dcmi-power install-service enable-service

install-script: ipmitool-exporter
	mkdir -p $(PREFIX)/bin/
	cp -v $< $(PREFIX)/bin/

install-script: ipmitool-exporter-dcmi-power
	mkdir -p $(PREFIX)/bin/
	cp -v $< $(PREFIX)/bin/ipmitool-exporter

install-service: prometheus-ipmitool.service
	mkdir -p /etc/systemd/system/
	cp -v prometheus-ipmitool.service /etc/systemd/system/
	systemctl daemon-reload

enable-service:
	systemctl enable prometheus-ipmitool
	systemctl stop prometheus-ipmitool
	systemctl start prometheus-ipmitool
