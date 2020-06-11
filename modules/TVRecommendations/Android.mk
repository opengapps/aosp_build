LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := TVRecommendations
LOCAL_PACKAGE_NAME := com.google.android.tvrecommendations.leanback
GAPPS_LOCAL_OVERRIDES_PACKAGES := TVRecommendationsNoGMS
LOCAL_PRIVILEGED_MODULE := true

include $(BUILD_GAPPS_PREBUILT_APK)
