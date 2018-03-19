# Always needed
PRODUCT_COPY_FILES += $(call gapps-copy-to-system,all,framework)

GAPPS_NEXUS_CODENAMES += \
    full_maguro \
    full_toro \
    full_toroplus \
    aosp_grouper \
    aosp_tilapia \
    aosp_manta \
    aosp_mako \
    aosp_flo \
    aosp_deb \
    aosp_hammerhead \
    aosp_flounder \
    aosp_shamu \
    aosp_angler \
    aosp_bullhead

GAPPS_PIXEL_CODENAMES += \
    aosp_marlin \
    aosp_sailfish \
    aosp_muskie \
    aosp_taimen \
    aosp_wahoo

gapps_etc_files := $(call gapps-copy-to-system,all,etc)

# Remove google_build.xml on non-Pixel devices
ifeq ($(filter $(GAPPS_PIXEL_CODENAMES),$(TARGET_PRODUCT)),)
  gapps_etc_files := $(filter-out %sysconfig/google_build.xml,$(gapps_etc_files))
endif

# Remove nexus.xml on non-Nexus devices
ifeq ($(filter $(GAPPS_NEXUS_CODENAMES),$(TARGET_PRODUCT)),)
  gapps_etc_files := $(filter-out %sysconfig/nexus.xml,$(gapps_etc_files))
endif

# This is included as part of GoogleDialer build, for devices that have the
# GoogleDialer
gapps_etc_files := $(filter-out %sysconfig/dialer_experience.xml,$(gapps_etc_files))

PRODUCT_COPY_FILES += $(gapps_etc_files)

# check if we are building a vendor image
ifneq ($(CALLED_FROM_SETUP),true)
BUILD_VENDORIMAGE := $(shell CALLED_FROM_SETUP=true BUILD_SYSTEM=build/core \
      command make --no-print-directory -f build/core/config.mk dumpvar-BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE)
endif

# Pico and higher
ifneq ($(filter pico,$(TARGET_GAPPS_VARIANT)),)
# vendor/pittpatt seems to be removed on N+ (so only copy it to older than N)
ifeq ($(filter 24,$(call get-allowed-api-levels)),)
  PITTPATT_COPY_FILES := $(call gapps-copy-to-system,all,vendor/pittpatt)
# if we are building a vendor image, then we cannot copy to system/vendor, so update our copy statements.
ifdef BUILD_VENDORIMAGE
  PITTPATT_COPY_FILES := $(subst :system/vendor/pittpatt,:vendor/pittpatt,$(PITTPATT_COPY_FILES))
endif
  PRODUCT_COPY_FILES += $(PITTPATT_COPY_FILES)
endif
  PRODUCT_COPY_FILES += $(call gapps-copy-to-system,all,usr/srec)
endif

# Reset internal variables
gapps_etc_files :=
