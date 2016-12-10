#!/bin/sh

lang=en_US
for o in $(cat /proc/cmdline); do
    case $o in
       lang=*)
          eval $o
          ;;
    esac
done

# we need the _NOT so there is always a field 2
Country=$(echo "$lang"_NOT | cut -d_ -f2)
Language=$(echo "$lang" | cut -d_ -f1)

file="/etc/langset/$Language""_$Country"
if ! test -f "$file"; then
  file="/etc/langset/$Language"
fi

sed -e 's,: *,:,' "$file" | while read line; do
  key=`echo $line | cut -d: -f1`
  value=`echo $line | cut -d: -f2-`

  sed -i -e "s#$key=\".*#$key=\"$value\"#" /etc/sysconfig/language
  sed -i -e "s#$key=\".*#$key=\"$value\"#" /etc/sysconfig/keyboard
  sed -i -e "s#$key=\".*#$key=\"$value\"#" /etc/sysconfig/console
done

echo "$Language""_$Country" > /var/lib/zypp/RequestedLocales

cmdline=$(cat /proc/cmdline | sed -e 's,.*splash=silent,splash=silent,')
echo "Cmdline: $cmdline" >> /etc/install.inf
if test -d /sys/firmware/efi/vars/; then
  echo "EFI: 1" >> /etc/install.inf
else
  echo "EFI: 0" >> /etc/install.inf
fi
