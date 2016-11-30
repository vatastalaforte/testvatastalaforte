# myKata job done!!!

ASSUMPTIONS:

- You must have preferably the last version of Ubuntu Desktop ( 16.10 )
- Your user must have the NOPWD:ALL on sudoers file or allow the members of sudo group ( using sudo visudo )
- You must know the interface adapter of your laptop through which you connect to Internet because the script ask for It 
- The Ubuntu Server 14 x64 image was created using an unattend installation with the following howto: http://gyk.lt/ubuntu-14-04-desktop-unattended-installation/. You will find in this project the file created by system-config-kickstart ( ks.cfg and ubuntu-auto.seed )
- The Ubuntu Server 14 x64 image will be downloaded, as a tar compressed file, from a Dropbox link ( 550MB )
- The Ubuntu Server 14 x64 image is secured with active firewall ( ufw ) that permits only http and ssh connections
- The root database password is secured for administrative purposes, the wordpress user will obtain only It's own credentials

WORDPRESS CONFIGURATION:

In this project you'll find the following files:

- wp-config.php, used for configuration with db credentials
- setup-wordpress.sh, used for configure the default web application
- start-wordpress-setup.sh, will run setup-wordpress.sh

SYSTEM CONFIGURATION:

In this project you'll find the following files:

- The main file start.sh, It's responsable to execute the entire project
- installPackages.sh, necessary for the LAMW installation ( note, not LAMP because MySQL was installed before :-) ) 

Please fork the project, pull It and place installPackages.sh, start.sh, setup-wordpress.sh, wp-config.php and start-wordpress-setup.sh in your $HOME directory
