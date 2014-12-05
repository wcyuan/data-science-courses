data-science-courses
====================

for coursera johns hopkins data science courses

setup r-studio server:

On an aws ubuntu instance, I tried to follow instructions at
http://www.rstudio.com/products/rstudio/download-server/.

Those instructions say you need at least R version 2.11.1 or higher
and it recommends adding the CRAN repository to your system before
getting R so you get the most up to date version.
   http://cran.rstudio.com/bin/linux/ubuntu/README.html
But when I did that, I continually ran into problems installing r-base
and r-base-core, it was not able to install all the dependencies.
So I undid it and just stuck with the default version, which was
version 3.0.2 anyway.

  $ sudo apt-get install r-base
  $ sudo apt-get install gdebi-core
  $ sudo apt-get install libapparmor1 # Required only for Ubuntu, not Debian
  $ wget http://download2.rstudio.org/rstudio-server-0.98.1091-i386.deb
  $ sudo gdebi rstudio-server-0.98.1091-i386.deb

As soon as it is installed, it starts running, and if the machine is bounced
it will restart when the machine is restarted.  To verify that things are
working, and to restart rstudio-server run this:

  $ sudo rstudio-server verify-installation
  rstudio-server stop/waiting
  rstudio-server start/running, process 734

Add port 8787 to the AWS security key's incoming access.

Access the server at
  http://my-ip:8787/

The server uses the system's usernames and passwords.  By default,
an aws ubuntu server only has user ubuntu and I don't know the
password.  So we need to set up a new user for rstudio

  $ sudo adduser <username>

This will prompt you for a password (and some oher stuff that doesn't matter)
It will also create the home directory.

adduser is a perl wrapper around the lower level command 'useradd'.  If
you use useradd directly, you'll need to set the password with passwd,
and you'll need to create the home directory yourself.  In short, don't
use useradd directly, always use adduser.  Similarly, remove users with
deluser, not userdel.

http://askubuntu.com/questions/345974/what-is-the-difference-between-adduser-and-useradd

----

Here's what I tried to do to add CRAN (but this failed)

  # Add CRAN
  deb http://cran.cnr.Berkeley.edu/bin/linux/ubuntu utopic/

to /etc/apt/sources.list.  Go to SECURE APT on that page to find the command

   sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

Then run

   sudo apt-get update
   sudo apt-get upgrade
   sudo apt-get install r-base


