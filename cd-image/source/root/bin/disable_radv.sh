#! /bin/bash
file="/usr/share/vulkan/icd.d/radeon_icd.x86_64.json"

if [ -f "$file" ]
then
mv $file $file.back
echo "Radv disable"
else
echo "Radv already disabled"
fi
