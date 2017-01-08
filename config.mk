ifneq ($(GAPPS_VARIANT),)

# Opengapps AOSP build system
GAPPS_BUILD_SYSTEM_PATH := vendor/google/build/core
GAPPS_SOURCES_PATH := vendor/opengapps/sources
GAPPS_DEVICE_FILES_PATH := vendor/google/build
GAPPS_FILES := $(GAPPS_DEVICE_FILES_PATH)/opengapps-files.mk
GAPPS_CLEAR_VARS := $(GAPPS_BUILD_SYSTEM_PATH)/clear_vars.mk

ifeq ($(GAPPS_FORCE_MATCHING_DPI),)
  GAPPS_FORCE_MATCHING_DPI := false
endif

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

GAPPS_LUNZIP_REQUIRED := $(shell find $(GAPPS_SOURCES_PATH) -name '*.apk.lz' -print -quit)
ifneq ($(GAPPS_LUNZIP_REQUIRED),)
  GAPPS_TEST_LUNZIP := $(shell command -v lunzip)
  ifeq ($(GAPPS_TEST_LUNZIP),)
    $(error lunzip is not available. Please install it first ("sudo apt-get install lunzip"))
  endif

  ifneq ($(filter clean installclean, $(MAKECMDGOALS)),)
    $(shell find $(GAPPS_SOURCES_PATH) -name "*apk.lz" | sed 's/\.apk\.lz$$/\.apk/' | xargs rm -f)
  endif
endif

include $(GAPPS_BUILD_SYSTEM_PATH)/definitions.mk

# Device should define their GAPPS_VARIANT in device/manufacturer/product/BoardConfig.mk
GAPPS_VARIANT_EVAL := $(call get-gapps-variant,$(GAPPS_VARIANT))

ifeq ($(GAPPS_VARIANT_EVAL),)
  $(error GAPPS_VARIANT $(GAPPS_VARIANT) was not found. Use of one of pico,nano,micro,mini,full,stock,super)
endif

TARGET_GAPPS_VARIANT := $(GAPPS_VARIANT_EVAL)

endif
