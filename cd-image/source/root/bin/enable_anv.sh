#! /bin/bash
file="/usr/share/vulkan/icd.d/intel_icd.x86_64.json.back"

if [ -f "$file" ]
then
mv $file /usr/share/vulkan/icd.d/intel_icd.x86_64.json
echo "Anv enable"
else
echo "Anv already enabled"
fi
