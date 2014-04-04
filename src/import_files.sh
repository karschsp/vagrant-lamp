wget --tries=3 172.16.63.5/sites/default/files/files.tar.gz &&
tar xzvf files.tar.gz 
mv files files_tmp
cp -rf files_tmp/* /vagrant/www/docroot/sites/default/files/ && 
rm -Rf files.tar.gz files_tmp 
