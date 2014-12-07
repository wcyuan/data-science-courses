data-science-courses
====================

for coursera johns hopkins data science courses

## Useful git repos

Notes are at:
https://github.com/DataScienceSpecialization/courses

But apparently each of the instructors has their own fork:
https://github.com/bcaffo/courses
https://github.com/rdpeng/courses

Swirl:
https://github.com/swirldev/swirl/wiki/Installing-swirl-on-Linux

## Setup r-studio server

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

```bash
  $ sudo apt-get install r-base
  $ sudo apt-get install gdebi-core
  $ sudo apt-get install libapparmor1 # Required only for Ubuntu, not Debian
  $ wget http://download2.rstudio.org/rstudio-server-0.98.1091-i386.deb
  $ sudo gdebi rstudio-server-0.98.1091-i386.deb
```

As soon as it is installed, it starts running, and if the machine is bounced
it will restart when the machine is restarted.  To verify that things are
working, and to restart rstudio-server run this:

```bash
  $ sudo rstudio-server verify-installation
  rstudio-server stop/waiting
  rstudio-server start/running, process 734
```

Add port 8787 to the AWS security key's incoming access.

Access the server at http://my-ip:8787/

The server uses the system's usernames and passwords.  By default,
an aws ubuntu server only has user ubuntu and I don't know the
password.  So we need to set up a new user for rstudio

```bash
  $ sudo adduser <username>
```

This will prompt you for a password (and some oher stuff that doesn't matter)
It will also create the home directory.

adduser is a perl wrapper around the lower level command 'useradd'.  If
you use useradd directly, you'll need to set the password with passwd,
and you'll need to create the home directory yourself.  In short, don't
use useradd directly, always use adduser.  Similarly, remove users with
deluser, not userdel.

http://askubuntu.com/questions/345974/what-is-the-difference-between-adduser-and-useradd

----

Actually, I see that the course recommends R version 3.1.1.  To upgrade
to that, I ran
```bash
  $ sudo add-apt-repository ppa:marutter/rrutter
  $ sudo apt-get update
  $ sudo apt-get upgrade
```

Then I restarted rstudio-server with verify-installation (not sure if this
is necessary).  Then, from inside rstudio, I quit rstudio and started
a new session, and that new session had the new version of R.

----

In one lecture, they give an example and say that you may need the library "UsingR".
I tried installing this from inside RStudio:
```R
> install.packages("UsingR")
```
The first time I tried it, I got a lot of errors like:
```R
Warning in install.packages :
  system call failed: Cannot allocate memory
Warning in install.packages :
  installation of package 'UsingR' had non-zero exit status
```

From
http://stackoverflow.com/questions/21785616/ubuntu-12-04-r-install-packages-does-not-work-no-warning-no-install,
I decided to try setting up swaps by following the directions at
https://www.digitalocean.com/community/tutorials/how-to-add-swap-on-ubuntu-12-04
```bash

 # check to see if there is an existing swap
 $ sudo swapon -s

 # make sure we have enough disk space free, need at least 256k
 $ df -h

 # make the swap.  this will only last until the machine is rebooted
 $ sudo dd if=/dev/zero of=/swapfile bs=1024 count=256k
 $ sudo mkswap /swapfile

 # results in:
 # Setting up swapspace version 1, size = 262140 KiB
 # no label, UUID=2193e5eb-0482-420c-9a7d-53558084fd06

 $ sudo swapon /swapfile

 # confirm that you can see it:
 $ swapon -s

```

After that, the install.packages command worked.

Aside from 'UsingR', I also installed 'ggplot2', 'dplyr', and 'reshape'

----

an intro for programmers

http://www.johndcook.com/blog/r_language_for_programmers/

----

Here's what I tried to do to add CRAN (but this failed)

```
  # Add CRAN
  deb http://cran.cnr.Berkeley.edu/bin/linux/ubuntu utopic/
```

to /etc/apt/sources.list.  Go to SECURE APT on that page to find the command to download the gpg key

```bash
   sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
```

Then run

```bash
   sudo apt-get update
   sudo apt-get upgrade
   sudo apt-get install r-base
```

Now I know why this failed.  In the first command "utopic" refers to the name of the Ubuntu release.  You have to
put the right value for your release.  My release is actually "trusty", not "utopic".  You can get the name of your
release like this:

```bash
# Grabs your version of Ubuntu as a BASH variable
CODENAME=`grep CODENAME /etc/lsb-release | cut -c 18-`
```
