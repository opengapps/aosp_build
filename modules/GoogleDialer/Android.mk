LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := GoogleDialer
LOCAL_PACKAGE_NAME := com.google.android.dialer
LOCAL_PRIVILEGED_MODULE := true

GAPPS_LOCAL_OVERRIDES_MIN_VARIANT :=
GAPPS_LOCAL_OVERRIDES_PACKAGES := Dialer

LOCAL_REQUIRED_MODULES := GoogleDialer_dialer_experience.xml

include $(BUILD_GAPPS_PREBUILT_APK)

include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)

LOCAL_MODULE := GoogleDialer_dialer_experience.xml
LOCAL_MODULE_STEM := dialer_experience.xml
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES := $(GAPPS_SOURCES_PATH)/all/etc/sysconfig/dialer_experience.xml
LOCAL_MODULE_PATH := $(TARGET_OUT_ETC)/sysconfig

include $(BUILD_PREBUILT)
