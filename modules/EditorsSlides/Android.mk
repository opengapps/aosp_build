LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE := EditorsSlides
LOCAL_PACKAGE_NAME := com.google.android.apps.docs.editors.slides

include $(BUILD_GAPPS_PREBUILT_APK)
