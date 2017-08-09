LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE := PrebuiltNewsWeather
LOCAL_PACKAGE_NAME := com.google.android.apps.genie.geniewidget

include $(BUILD_GAPPS_PREBUILT_APK)
