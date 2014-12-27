[Gears on Gallium](http://www.gearsongallium.com)
==============

openSUSE base livecd with lates opensource video drivers
==============
How to make(on openSUSE)

zypper in kiwi kiwi-tools kiwi-desk-isoboot

copy /suse-gog to /usr/share/kiwi/image/isoboot

cd ./cd-image/

kiwi -p ./source/ --root ./image

kiwi -c ./image -d ./dist

Write  the ./dist/image-name.iso image  to cd or usb
