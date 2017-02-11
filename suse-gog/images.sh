#!/bin/sh
test -f /.kconfig && . /.kconfig
test -f /.profile && . /.profile

echo "Configure image: [$kiwi_iname]..."

#==========================================
# setup build day
#------------------------------------------
baseSetupBuildDay
depmod -a
#==========================================
# remove unneded kernel files
#------------------------------------------
suseStripKernel

#==========================================
# remove unneeded files
#------------------------------------------
suseStripInitrd

#==========================================
# umount
#------------------------------------------
baseCleanMount

exit 0
