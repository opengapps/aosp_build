LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE := EditorsDocs
LOCAL_PACKAGE_NAME := com.google.android.apps.docs.editors.docs

include $(BUILD_GAPPS_PREBUILT_APK)
