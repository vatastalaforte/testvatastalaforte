sudo mv /var/www/html/setup-wordpress.sh /var/www/html/wp-admin/setup-wordpress.sh
sudo chmod 755 /var/www/html/wp-admin/setup-wordpress.sh
sudo /var/www/html/wp-admin/setup-wordpress.sh testSite wordpress wordpressuser@wordpress.com wordpress2016 > /dev/null
