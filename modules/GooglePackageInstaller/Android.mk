LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_MODULE := GooglePackageInstaller
LOCAL_PACKAGE_NAME := com.google.android.packageinstaller
LOCAL_PRIVILEGED_MODULE := true

GAPPS_LOCAL_OVERRIDES_PACKAGES := PackageInstaller

include $(BUILD_GAPPS_PREBUILT_APK)
