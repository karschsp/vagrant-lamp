#!/usr/bin/env bash

cd ~
sudo curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
sed -i '1i export PATH="$HOME/.composer/vendor/bin:$PATH"' $HOME/.bashrc
sudo /usr/local/bin/composer global require drush/drush:6.*
mysql -u root -e "GRANT ALL ON *.* TO 'root'@'%';FLUSH PRIVILEGES;"