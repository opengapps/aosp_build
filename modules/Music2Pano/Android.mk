LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := Music2Pano
LOCAL_PACKAGE_NAME := com.google.android.music.leanback

include $(BUILD_GAPPS_PREBUILT_APK)
