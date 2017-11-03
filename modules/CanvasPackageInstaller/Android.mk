LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_CERTIFICATE := platform
LOCAL_MODULE := CanvasPackageInstaller
LOCAL_PACKAGE_NAME := com.google.android.pano.packageinstaller
LOCAL_PRIVILEGED_MODULE := true
include $(BUILD_GAPPS_PREBUILT_APK)

