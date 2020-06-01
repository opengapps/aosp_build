LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := PlayGamesPano
LOCAL_PACKAGE_NAME := com.google.android.play.games.leanback

include $(BUILD_GAPPS_PREBUILT_APK)
