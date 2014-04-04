#!/bin/sh
mysqladmin -u root DROP db
mysqladmin -u root CREATE db
mysql -u root -D db < db.sql
