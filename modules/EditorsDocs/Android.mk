LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := EditorsDocs
LOCAL_PACKAGE_NAME := com.google.android.apps.docs.editors.docs
LOCAL_CERTIFICATE := PRESIGNED

include $(BUILD_GAPPS_PREBUILT_APK)
