#!sbin/sh

#
# use ro.build.fingerprint,
# use ro.build.version.release, ro.build.version.security_patch, ro.vendor.build.security_patch
# from system/build.prop or vendor/build.prop instead of default.prop
#
# for noAB slot
# for BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
# for vendor/build.prop
# for keymaster-3.0+
#
# by wzsx150
# v2.9-20191028
#
# Modified By コーヒー Ko-Hi
# Added begoniain OTA support
# 

SYSTEM_TMP=/system_root/system
VENDOR_TMP=/vendor

mount /system_root
mount /vendor
usleep 100

temp=`cat "$SYSTEM_TMP/system/build.prop" \
          "$SYSTEM_TMP/build.prop" \
          "$VENDOR_TMP/build.prop" \
          /default.prop 2>/dev/null`
usleep 100

umount system_root &

fingerprint=`echo "$temp" | grep -F "ro.build.fingerprint=" -m 1 | cut -d'=' -f2` && resetprop "ro.build.fingerprint" "$fingerprint" &
RELEASE=`echo "$temp" | grep -F "ro.build.version.release=" -m 1 | cut -d'=' -f2` && resetprop "ro.build.version.release" "$RELEASE" &
PATCH=`echo "$temp" | grep -F "ro.build.version.security_patch=" -m 1 | cut -d'=' -f2` && resetprop "ro.build.version.security_patch" "$PATCH" &
SDK=`echo "$temp" | grep -F "ro.build.version.sdk=" -m 1 | cut -d'=' -f2` && resetprop "ro.build.version.sdk" "$SDK" &
VENPATCH=`echo "$temp" | grep -F "ro.vendor.build.security_patch=" -m 1 | cut -d'=' -f2` && resetprop "ro.vendor.build.security_patch" "$VENPATCH" &

umount /vendor &

setprop "twrp.fingerprintid.prop" "1" &
setprop "twrp.fingerprintid.sys_root" "1" &
setprop "twrp.fingerprintid.system" "$systempart" &
setprop "twrp.fingerprintid.vendor" "$vendorpart" &

sleep 1

touch /sbin/fingerprint_ready

sleep 2


exit 0




