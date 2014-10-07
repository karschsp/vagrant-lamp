#!/usr/bin/env bash

cd /home/vagrant
sudo -u vagrant curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
sudo -u vagrant sed -i '1i export PATH="/home/vagrant/.composer/vendor/bin:$PATH"' /home/vagrant/.bashrc
sudo -u vagrant /usr/local/bin/composer global require drush/drush:6.*
mysql -u root -e "GRANT ALL ON *.* TO 'root'@'%';FLUSH PRIVILEGES;"

# INSTALL SOLR
# run command: sudo ./installsolr.sh
# final solr url will be: http://localhost:8983/solr/core0
# will install the files at /opt/solr45
# command: sudo ./solrinstall.sh

#stop the existing solr install from len
sudo killall java
#install new solr
#uncomment the below and to use wget and comment out the the curl line
#wget http://apache.mirrors.lucidnetworks.net/lucene/solr/4.5.0/solr-4.5.0.tgz
curl -O http://apache.mirrors.lucidnetworks.net/lucene/solr/4.7.2/solr-4.7.2.tgz
gunzip solr-4.7.2.tgz
tar -xvf solr-4.7.2.tar
sudo mv solr-4.7.2 /opt/solr472
cd /opt/solr472
sudo rm -Rf *.txt docs
cd example
sudo cp -R contexts etc lib logs resources start.jar webapps solr-webapp multicore ..
cd ..
sudo mv multicore solr
sudo rm -Rf solr/README.txt
#copy the solr core0 with configs to the solr location
echo "removed and copied files, starting server..."
sudo cp -Rf /vagrant/src/core0 /opt/solr472/solr
sudo java -jar -Dsolr.solr.home=/opt/solr472/solr start.jar >>log.txt 2>&1 &
