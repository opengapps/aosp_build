# Opengapps AOSP build system
GAPPS_BUILD_SYSTEM_PATH := vendor/google/build/core
GAPPS_SOURCES_PATH := vendor/opengapps/sources
GAPPS_DEVICE_FILES_PATH := vendor/opengapps/build
GAPPS_FILES := $(GAPPS_DEVICE_FILES_PATH)/opengapps-files.mk

include $(GAPPS_BUILD_SYSTEM_PATH)/definitions.mk
