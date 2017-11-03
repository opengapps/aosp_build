LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_CERTIFICATE := platform
LOCAL_MODULE := AtvRemoteService
ifneq ($(filter $(call get-allowed-api-levels),24),)
LOCAL_PACKAGE_NAME := com.google.android.tv.remote.service.leanback
else
LOCAL_PACKAGE_NAME := com.google.android.tv.remote
LOCAL_SHARED_LIBRARIES += libatv_uinputbridge
endif
LOCAL_PRIVILEGED_MODULE := true
LOCAL_DEX_PREOPT := false
include $(BUILD_GAPPS_PREBUILT_APK)

include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE_SUFFIX := $(TARGET_SHLIB_SUFFIX)
LOCAL_MODULE := libatv_uinputbridge
full_name := $(LOCAL_MODULE)$(LOCAL_MODULE_SUFFIX)
ifdef TARGET_2ND_ARCH
  LOCAL_SRC_FILES := $(call gapps-find-lib-for-arch,$(TARGET_2ND_ARCH),$(lib_prefix)lib,$(full_name))
  LOCAL_MODULE_PATH := $($(TARGET_2ND_ARCH_VAR_PREFIX)TARGET_OUT_SHARED_LIBRARIES)
else
  LOCAL_SRC_FILES := $(call gapps-find-lib-for-arch,$(TARGET_ARCH),$(lib_prefix)lib,$(full_name))
  LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
endif
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_MODULE_TAGS := optional
include $(BUILD_PREBUILT)
