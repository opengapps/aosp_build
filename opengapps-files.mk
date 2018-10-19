GAPPS_NEXUS2015_CODENAMES += \
    %angler \
    %bullhead

GAPPS_NEXUS_CODENAMES += \
    %maguro \
    %toro \
    %toroplus \
    %grouper \
    %tilapia \
    %manta \
    %mako \
    %flo \
    %deb \
    %hammerhead \
    %flounder \
    %shamu \
    $(GAPPS_NEXUS2015_CODENAMES)

GAPPS_PIXEL2016_CODENAMES += \
    %marlin \
    %sailfish

GAPPS_PIXEL2017_CODENAMES += \
    %muskie \
    %taimen \
    %wahoo \
    %walleye

GAPPS_PIXEL_CODENAMES += \
    $(GAPPS_PIXEL2016_CODENAMES) \
    $(GAPPS_PIXEL2017_CODENAMES)

gapps_etc_files := $(call gapps-copy-to-system,all,etc)
gapps_framework_files := $(call gapps-copy-to-system,all,framework)

# Remove experimental2015 camera on non-Nexus 2015 devices
ifeq ($(filter $(GAPPS_NEXUS2015_CODENAMES),$(TARGET_PRODUCT)),)
  gapps_etc_files := $(filter-out %permissions/com.google.android.camera.experimental2015.xml,$(gapps_etc_files))
  gapps_framework_files := $(filter-out %com.google.android.camera.experimental2015.jar,$(gapps_framework_files))
endif

# Remove experimental2016 camera on non-Pixel 2016 devices
ifeq ($(filter $(GAPPS_PIXEL2016_CODENAMES),$(TARGET_PRODUCT)),)
  gapps_etc_files := $(filter-out %permissions/com.google.android.camera.experimental2016.xml,$(gapps_etc_files))
  gapps_framework_files := $(filter-out %com.google.android.camera.experimental2016.jar,$(gapps_framework_files))
endif

# Remove experimental2017 camera on non-Pixel 2017 devices
ifeq ($(filter $(GAPPS_PIXEL2017_CODENAMES),$(TARGET_PRODUCT)),)
  gapps_etc_files := $(filter-out %permissions/com.google.android.camera.experimental2017.xml,$(gapps_etc_files))
  gapps_framework_files := $(filter-out %com.google.android.camera.experimental2017.jar,$(gapps_framework_files))
endif

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

PRODUCT_COPY_FILES += $(gapps_etc_files) $(gapps_framework_files)

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
