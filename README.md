A very simple Vagrant LAMP setup for Drupal 7 & Drupal 8 development/testing.

Two vhosts are created by default, drupal7.dev and drupal8.dev (make sure you add the following to your /etc/hosts file):

```
192.168.51.50	drupal7.dev
192.168.51.50	drupal8.dev
```

The vhosts roots are:

**/vagrant/www/drupal7.dev/docroot**

and

**/vagrant/www/drupal8.dev/docroot**


For Drupal 7 
```
git clone http://git.drupal.org/project/drupal.git --branch=7.x www/drupal7.dev/docroot
```

For Drupal 8 
```
git clone http://git.drupal.org/project/drupal.git --branch=8.0.x www/drupal8.dev/docroot
vagrant ssh
mysqladmin -u root CREATE drupal8
cd /vagrant/www/drupal8.dev/docroot/sites/default
cp default.settings.php settings.php && mkdir files && chmod 777 settings.php files
```

Now you should be able to go to http://drupal8.dev in your browser and follow your Drupal installation instructions from there.

