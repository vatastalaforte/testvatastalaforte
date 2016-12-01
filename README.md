# Go to live! kata

Contained in this repo, there are some instructions for a new application that will go live in the next month!

You will need to:

Fork this repository.

Automate the creation of the infrastructure and the setup of the application.

You have only these instructions:

2.1 It works on Ubuntu Linux 14.04 x64

2.2 It's based on the last version of WordPress (it will be more useful if we can parameterize the version)

2.3 You can choose Apache, Nginx or whatever you want

For any other issues or question you will have to ask to the developers. In this case please ask us without problems :)

Once deployed, the application should be secure, fast and stable. Assume that the machine is running on the public Internet and should be hardened and locked down.

Make any assumptions that you need to. This is an opportunity to showcase your skills, so if you want to, implement the deployment process with any additional features, tools or techniques you'd like to.

We are evaluating solutions based on the architecture and quality of the deployment. Show us just how beautiful, clean and pragmatic your code can be.

Once your solution is ready, please send us the link of your project.
# ---------------------------------------------
# Kata completed!!!

ASSUMPTIONS:

- This project is dedicated to that developers who need a local VM with a Wordpress installation/configuration, It's recommended a machine with a minumun of 4 cores, 8GB of RAM, SSD disk with 16GB free space
- You must have preferably the last version of Ubuntu Desktop ( 16.10 )
- Your user must have the NOPWD:ALL on sudoers file or allow the members of sudo group ( using sudo visudo )
- You must know the interface adapter of your laptop through which you connect to Internet because the script asks for It 
- The VirtualBox interface is natted for security reasons
- The Ubuntu Server 14 x64 image was created using the base image and an unattend installation procedure following this howto: http://gyk.lt/ubuntu-14-04-desktop-unattended-installation/. You will find in this project the file created by system-config-kickstart ( ks.cfg and ubuntu-auto.seed )
- The Ubuntu Server 14 x64 image will be downloaded, as a tar compressed file, from a Dropbox link ( 550MB )
- The Ubuntu Server 14 x64 image is secured with active firewall ( ufw ) that permits only http and ssh connections
- The root database password is secured for administrative purposes, the wordpress user will obtain only It's own credentials
- For security reasons, the last version of Wordpress will be installed
- During MySQL installation was removed the anonymous user login and disabled the auto remote login

WORDPRESS CONFIGURATION:

In this project you'll find the following files:

- wp-config.php, used for configuration with db credentials. For security reason were generated inside the security keys
- setup-wordpress.sh, used for configure the default web application
- start-wordpress-setup.sh, will run setup-wordpress.sh
- Regarding the choice to install the last version of WP for security reasons, in wp-config.php was added the option 'define( 'WP_AUTO_UPDATE_CORE', true );' that will perform major and minor updates automatically
- All WP directories have 755 permissions, all files have 644 permission and wp-config.php have 600 permission
- PHP Error reporting turned off to avoid hackers attack in case of an error that could display the server path
- For better security, could be useful to restrict .htacces file, limit login attempt and use common sense ( backup frequently, change passwords often...) 

SYSTEM CONFIGURATION:

In this project you'll find the following files:

- The main file start.sh, It's responsable to execute the entire project
- installPackages.sh, necessary for the LAMW installation ( note, not LAMP because MySQL was installed before :-) ) 

Please fork the project, pull It and place installPackages.sh, start.sh, setup-wordpress.sh, wp-config.php and start-wordpress-setup.sh in your $HOME directory.
At the end of the script, will be asked to enter the wordpress user password ( wordpress2016 ) to complete the default app configuration.
You'll be able to enter the Wordpress console with the following link: your-local-ip/wp-admin/

User: wordpress 
Password: wordpress2016

For any problems, If you need to start again the script, remember to remove the "wordpressubuntu_final" image from VirtualBox GUI!!!
