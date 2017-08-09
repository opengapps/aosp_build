LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE := BugReportSender
LOCAL_PACKAGE_NAME := com.google.tungsten.bugreportsender
include $(BUILD_GAPPS_PREBUILT_APK)

