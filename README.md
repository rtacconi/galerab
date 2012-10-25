GALERAD - Load balancer for MySql clusters using Galera replication
===================================================================

Installation
------------
install the dependencies:

gem install em-proxy --no-ri --no-rdoc
gem install ansi --no-ri --no-rdoc
gem install mysql --no-ri --no-rdoc
gem install sequel --no-ri --no-rdoc

Copy balancer to /usr/sbin and chmod to +x. The copy galerb to /etc/init.d/ and run:

chmod 755 galerab
update-rc.d galerab defaults

on Debian-like systems to link the script to the system levels.