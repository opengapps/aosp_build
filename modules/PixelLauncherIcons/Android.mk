LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE := PixelLauncherIcons
LOCAL_PACKAGE_NAME := com.google.android.nexusicons
LOCAL_DEX_PREOPT := false

include $(BUILD_GAPPS_PREBUILT_APK)
