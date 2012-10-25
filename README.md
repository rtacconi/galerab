# GALERAD
Load balancer for MySql clusters using Galera replication

## Installation

gem install em-proxy --no-ri --no-rdoc
gem install ansi --no-ri --no-rdoc
gem install mysql --no-ri --no-rdoc
gem install sequel --no-ri --no-rdoc
cp balancer /usr/sbin 
chmod +x /usr/sbin/balancer
cp galerb /etc/init.d/
chmod 755 /etc/init.d/galerab
cp galerab.yml /etc/
update-rc.d /etc/init.d/galerab defaults

This installation is for Debian-like systems to link the script to the system levels.

# Usage

service galerab start
service galerab stop