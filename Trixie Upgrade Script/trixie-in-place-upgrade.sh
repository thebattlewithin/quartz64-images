#!/bin/sh

##    Created by thebattlewithin
##    
##    
##
##    Run this program as root "sudo su -". this will help avoid and permissions issues during the upgrade process. 
##
##    The Sleep commands can be commented out if you find them annoying. They are just to make thing a bit more playful.
##    
## 
##    This script is hand coded. 
##    So, I might have missed something. 
##    Feel free to coach me. 
##    I will not take offense.
##    I am sure this could be done better.
##
##    This will first update the sources.list file to "trixie".
##    This will NOT change the Plebian specific source files. - At the moment, I'm not sure if our Pine64 overlords have had time in their busy schedule to update this part, yet. So, I've have omitted that part.
##    This will NOT change any file in /etc/apt/sources.list.d/ directory - So, Remember to change them accordingly if you have Docker or anything NOT plebian related in there. 
##
##    Directions for use:
##      1. Log in to system
##      2. Switch to root user with "sudo su -" or just run as a user with sudo privledges and skip this step.
##      3. cd /tmp
##      4. sudo nano trixie-in-place-upgrade.sh
##      5. copy this script entirely to the above mentioned file
##      6. save file. ctrl x, then, yes.
##      7. sudo chmod +x trixie-in-place-upgrade.sh
##      8. sudo ./trixie-in-place-upgrade.sh
##      9. Follow Prompts and Enjoy.

## Begin Program ##

# This checks if the user has root privileges
if [ "$EUID" -ne 0 ]
then echo "Please run as root"
    exit 1
fi

echo "Lets Get Started. If you're having second thoughts, press: Control C , now." 

sleep 3

echo "You have 10 Seconds to change your mind"

sleep 10

echo "Okay then..."

sleep 2

echo "Let's begin."

sleep 2

## Let's set the locale info first
echo "let's set the locale information first. this helps minimize errors and speeds things up a bit."
sleep 3

## Generates en_US.UTF-8 profile
locale-gen "en_US.UTF-8"
sleep 3

## That's better now to apply the locale change to Apt
echo "That's better. Now to apply the locale change to Apt. Follow the prompt and set accordingly"
sleep 3

## Applying locale to apt
sudo dpkg-reconfigure locales

## Prints the Following text updating sources.list by changing Bookworm/bookworm to Trixie/trixie
echo "updating sources.list by changing Bookworm/bookworm to Trixie/trixie"

## Finds and Replaces train “bookworm” with “trixie” case-sensitive
sudo sed -i 's/bookworm/trixie/g' /etc/apt/sources.list

## uncomment line below to upgrade an existing docker install as well
# sudo sed -i 's/bookworm/trixie/g' /etc/apt/sources.list.d/docker.list

## Finds and Replaces Title/comment of “Bookworm” with “Trixie” case-sensitive
sudo sed -i 's/Bookworm/Trixie/g' /etc/apt/sources.list
sleep 3

## Now, Let's update our changes.
echo "Finalizing changes and beginning update."
sleep 3

## Updates sources
sudo apt update

## Beginning upgrade
echo "Beginning Upgrade"
sleep 5

sudo apt full-upgrade -y
sleep 5

## Performing some housekeeping tasks
echo "Performing some housekeeping tasks" 
sleep 5

echo "Removing unused system progroms, Your files are safe."
sleep 10

sudo apt autoremove -y
sleep 5

echo "Deleting old files from the before-fore time. Again, Your files are safe. "
sleep 10

sudo apt autoclean -y
sleep 3

## Success Message
echo "Upgrade complete, reboot to finish the job."