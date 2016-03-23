# Opengapps AOSP build system
GAPPS_DEVICE_FILES_PATH := $(LOCAL_PATH)
GAPPS_BUILD_SYSTEM_PATH := $(GAPPS_DEVICE_FILES_PATH)/core
GAPPS_CLEAR_VARS := $(GAPPS_BUILD_SYSTEM_PATH)/clear_vars.mk
GAPPS_SOURCES_PATH ?= vendor/opengapps/sources
GAPPS_FORCE_MATCHING_DPI ?= false

ifeq ($(GAPPS_FORCE_MATCHING_DPI),false)
  GAPPS_AAPT_PATH := $(shell find prebuilts/sdk/tools/$(HOST_OS) -executable -name aapt | head -n 1)
  # Check if aapt is present in prebuilts or if it is installed.
  ifeq ($(wildcard $(GAPPS_AAPT_PATH)),)
    GAPPS_TEST_AAPT := $(shell command -v aapt)
    ifeq ($(GAPPS_TEST_AAPT),)
      $(error aapt is not available. Please install it first ("sudo apt-get install aapt") or define GAPPS_FORCE_MATCHING_DPI := true)
    else
      GAPPS_AAPT_PATH := aapt
    endif
  endif
endif

include $(GAPPS_BUILD_SYSTEM_PATH)/definitions.mk

# Device should define their GAPPS_VARIANT in device/manufacturer/product/device.mk
ifeq ($(GAPPS_VARIANT),)
  $(error GAPPS_VARIANT must be configured)
endif
TARGET_GAPPS_VARIANT := $(call get-gapps-variant,$(GAPPS_VARIANT))

ifeq ($(TARGET_GAPPS_VARIANT),)
  $(error GAPPS_VARIANT $(GAPPS_VARIANT) was not found. Use of one of pico,nano,micro,mini,full,stock,super)
endif

include $(GAPPS_DEVICE_FILES_PATH)/opengapps-packages.mk
include $(GAPPS_DEVICE_FILES_PATH)/opengapps-files.mk
