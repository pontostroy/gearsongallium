#! /bin/bash
file="/usr/share/vulkan/icd.d/radeon_icd.x86_64.json.back"

if [ -f "$file" ]
then
mv $file /usr/share/vulkan/icd.d/radeon_icd.x86_64.json
echo "Radv enable"
else
echo "Radv already enabled"
fi
