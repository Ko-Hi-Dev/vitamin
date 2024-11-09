#
# Copyright (C) 2022 The Android Open Source Project
# Copyright (C) 2022 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)


# Inherit from our custom product configuration.
$(call inherit-product, vendor/twrp/config/common.mk)

# Device specific configs.
$(call inherit-product, device/oneplus/vitamin/device.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := vitamin
PRODUCT_NAME := twrp_vitamin
PRODUCT_BRAND := oneplus
PRODUCT_MODEL := Oneplus Nord 3
PRODUCT_MANUFACTURER := Oneplus
PRODUCT_RELEASE_NAME := Nord 3
