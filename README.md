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

In your vagrant directory, create a **www** folder.
This will sync with **/vagrant/www** on your guest.
Within the www folder, create drupal7.dev &amp; drupal8.dev.

```
cd drupal7.dev
git clone http://git.drupal.org/project/drupal.git --branch=7.x docroot
cd ..
cd drupal8.dev
git clone http://git.drupal.org/project/drupal.git --branch=8.x docroot
```

Follow your Drupal installation instructions from there.

