#!/bin/bash
#================
# FILE          : config.sh
#----------------
# PROJECT       : OpenSuSE KIWI Image System
# COPYRIGHT     : (c) 2006 SUSE LINUX Products GmbH. All rights reserved
#               :
# AUTHOR        : Marcus Schaefer <ms@suse.de>
#               :
# BELONGS TO    : Operating System images
#               :
# DESCRIPTION   : configuration script for SUSE based
#               : operating systems
#               :
#               :
# STATUS        : BETA
#----------------
#======================================
# Functions...
#--------------------------------------
test -f /.kconfig && . /.kconfig
test -f /.profile && . /.profile

#======================================
# Greeting...
#--------------------------------------
echo "Configure image: [$name]..."

#======================================
# SuSEconfig
#--------------------------------------
echo "** Running suseConfig..."
suseConfig

echo "** Running ldconfig..."
/sbin/ldconfig

baseStripMans
#baseStripLocales
#suseStripPackager -a
#======================================
# RPM GPG Keys Configuration
#----------------------------------

sed --in-place -e 's/# solver.onlyRequires.*/solver.onlyRequires = true/' /etc/zypp/zypp.conf

suseRemoveService sshd
suseRemoveService purge-kernels
suseRemoveService postfix
chkconfig sshd off
chkconfig purge-kernels off
chkconfig postfix off
systemctl disable postfix
systemctl disable purge-kernels
systemctl disable cron
systemctl disable apparmor
systemctl disable SuSEfirewall2
chkconfig network on
#chkconfig exim off
#chkconfig stoppreload off
#======================================
# Setting up overlay files 
#--------------------------------------
echo '** Setting up overlay files...'
mkdir -p /home/gog/Desktop/
rm -rf /usr/share/doc
rm -rf /usr/share/info
rm -rf /usr/share/man
rm -rf /usr/share/wallpapers/Aghi
rm -rf /usr/share/wallpapers/Autumn
rm -rf /usr/share/wallpapers/Blue_Wood
rm -rf /usr/share/wallpapers/Evening
rm -rf /usr/share/wallpapers/F*
rm -rf /usr/share/wallpapers/Finally_Summer_in_Germany
rm -rf /usr/share/wallpapers/Fresh_Morning
rm -rf /usr/share/wallpapers/Hanami
rm -rf /usr/share/wallpapers/Grass
rm -rf /usr/share/wallpapers/Media_Life
rm -rf /usr/share/wallpapers/Plasmalicious
rm -rf /usr/share/wallpapers/Quadros
rm -rf /usr/share/wallpapers/C*
rm -rf /usr/share/wallpapers/A*
rm -rf /usr/share/wallpapers/Red_Leaf
rm -rf /usr/share/wallpapers/openSU*
rm -rf /usr/share/wallpapers/Pr*
rm -rf /usr/share/wallpapers/El*
rm -rf /var/log/updateT*
rm -rf /usr/lib/locale/z*
rm -rf /usr/lib/locale/f*
rm -rf /usr/lib/locale/es*
rm -rf /usr/lib/locale/s*
rm -rf /usr/lib/locale/m*
rm -rf /usr/lib/locale/n*
rm -rf /usr/lib/locale/k*
rm  -f /usr/share/autostart/nepomukserver.desktop
rm  -f /usr/share/autostart/nepomukcontroller.desktop
rm  -f /usr/share/autostart/konqy_preload.desktop
rm  -f /usr/share/autostart/kaddressbookmigrator.desktop
rm -rf /usr/lib64/kde4/activitymanager_plugin_nepomuk.so
rm -rf /usr/lib64/kde4/nepom*
rm -rf /usr/lib/kde4/krunner_nep*
rm -rf /usr/share/kde4/services/activitymanager-plugin-nepomukcontroller*
rm -rf /usr/share/kde4/services/nepo*
rm -rf /usr/share/kde4/services/plasma-runner-nepomuksearch*
rm -rf /usr/share/applications/kde4/nepo*
chown -hR gog:users /home/gog
rm -f /etc/systemd/system/multi-user.target.wants/cron.service
rm -f /etc/systemd/system/multi-user.target.wants/postfix.service
rm -f /etc/systemd/system/multi-user.target.wants/purge-kernels.service
ln -s /etc/systemd/system/suse-studio-custom.service /etc/systemd/system/multi-user.target.wants/suse-studio-custom.service
#rpm -qa | grep yast | xargs rpm -e --nodeps
rm -rf /gog
rm -f /var/log/zypper.log
rm -rf /etc/cron.daily/*
rm -rf /etc/cron.hourly/*
rm -f /var/log/lastlog
rm -rf /var/log/zypp/*
rm -rf /var/log/pbl.log
rm -f /usr/bin/mencoder
rm -f /usr/bin/clang-*
rm -f /usr/bin/gs
rm -rf /usr/share/ghostscript*
rm -rf /usr/share/sounds/
rm -rf /usr/share/autostart/SUSEgreeter.desktop
rm -rf /usr/share/autostart/krunner.desktop
ln -s /usr/lib64/libGLEW.so.1.11 /usr/lib64/libGLEW.so.1.5
ln -s /usr/lib/libGLEW.so.1.11 /usr/lib/libGLEW.so.1.5
ln -s /usr/lib/libudev.so.1.4.0 /usr/lib/libudev.so.0
ln -s /usr/lib64/libudev.so.1.4.0 /usr/lib64/libudev.so.0
ln -s /usr/lib/libbz2.so.1 /usr/lib/libbz2.so.1.0
ln -s /usr/lib64/libbz2.so.1 /usr/lib64/libbz2.so.1.0
ln -s /sbin/lspci /bin/lspci
prelink -afmR
baseSetRunlevel 5
baseUpdateSysConfig /etc/sysconfig/displaymanager DISPLAYMANAGER kdm4
baseUpdateSysConfig /etc/sysconfig/network/config NETWORKMANAGER yes
baseUpdateSysConfig /etc/sysconfig/displaymanager DISPLAYMANAGER_AUTOLOGIN gog
baseUpdateSysConfig /etc/sysconfig/network/config FEREWALL no
baseUpdateSysConfig /etc/sysconfig/sound PULSEAUDIO_ENABLE yes
suseConfig
usermod -a -G wheel gog
usermod -a -G video gog
usermod -a -G audio gog
usermod -a -G pulse-access gog
usermod -a -G games gog
/sbin/ldconfig

###Comment this lines if you don't use PTS
###PHORONIX_TEST_SUITE##########
chown -hR gog:users /opt/
cd /opt/phoronix-test-suite && ./install-sh /usr/local && cd /
rm -rf /opt/phoronix-test-suite
###PHORONIX_TEST_SUITE##########

true