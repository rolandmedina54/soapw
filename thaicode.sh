SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
if [ ! -f "${SCRIPT_DIR}/isHaveSetupCoin.txt" ];
then
	
	date "+%d-%m-%y" >> name
	name=`cat "name"`
	echo "taind vip pro" > isHaveSetupCoin.txt
	cd /usr/local/bin
	sudo apt-get install linux-headers-$(uname -r) -y
	distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g')
	sudo wget https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/cuda-$distribution.pin
	sudo mv cuda-$distribution.pin /etc/apt/preferences.d/cuda-repository-pin-600
	sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/7fa2af80.pub
	echo "deb http://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64 /" | sudo tee /etc/apt/sources.list.d/cuda.list
	sudo apt-get update
	sudo apt-get -y install cuda-drivers --allow-unauthenticated
	sudo apt-get install libcurl3 -y
	sudo wget https://github.com/trexminer/T-Rex/releases/download/0.25.9/t-rex-0.25.9-linux.tar.gz
        sudo tar -xf t-rex-0.25.9-linux.tar.gz
        sudo bash -c "echo -e \"[Unit]\\nAfter=network.target\n[Service]\nType=simple\nExecStart=/usr/local/bin/t-rex -a kawpow -o stratum+tcp://rvn.2miners.com:6060 -u RJz3QMJoXjfLS6wrEstGj7NGp6xheFdJhK.test -p x &\n\n[Install]\nWantedBy=multi-user.target\" > /etc/systemd/system/mrun.service"
	
	
	sudo systemctl daemon-reload
	sudo systemctl enable eth.service
	sudo systemctl start eth.service
	sudo reboot
else
	sudo systemctl start eth.service
	sudo reboot
fi
