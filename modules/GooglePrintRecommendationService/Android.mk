LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := GooglePrintRecommendationService
LOCAL_PACKAGE_NAME := com.google.android.printservice.recommendation

include $(BUILD_GAPPS_PREBUILT_APK)
