echo "Execute apt-get update"
sudo apt-get update -y

echo "Installing Apache2..."
sudo apt-get install apache2 -y

echo "Installing php..."
sudo apt-get install php5 php5-mcrypt libapache2-mod-php5 -y
sudo apt-get install php5-mysqlnd-ms -y

echo "Downloading Wordpress..."
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
sudo mv wordpress/* /var/www/html
sudo rm /var/www/html/index.html

sudo chown wordpress /var/www/html/
