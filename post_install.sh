#!/usr/bin/env bash

sudo service mysqld restart
sudo service httpd restart
sudo service memcached restart
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
sed -i '1i export PATH="$HOME/.composer/vendor/bin:$PATH"' $HOME/.bashrc
composer global require drush/drush:6.*