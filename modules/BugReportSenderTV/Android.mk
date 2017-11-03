LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_CERTIFICATE := platform
LOCAL_MODULE := BugReportSenderTV
LOCAL_PACKAGE_NAME := com.google.android.tv.bugreportsender
include $(BUILD_GAPPS_PREBUILT_APK)

