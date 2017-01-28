#! /bin/bash
file="/usr/share/vulkan/icd.d/intel_icd.x86_64.json"

if [ -f "$file" ]
then
mv $file $file.back
echo "Anv disable"
else
echo "Anv already disabled"
fi
