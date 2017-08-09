LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE := GooglePrintRecommendationService
LOCAL_PACKAGE_NAME := com.google.android.printservice.recommendation

GAPPS_LOCAL_OVERRIDES_MIN_VARIANT :=
GAPPS_LOCAL_OVERRIDES_PACKAGES := PrintRecommendationService

include $(BUILD_GAPPS_PREBUILT_APK)
