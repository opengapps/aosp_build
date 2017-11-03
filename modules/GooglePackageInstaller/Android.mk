LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE := GooglePackageInstaller
ifneq ($(filter tv,$(PRODUCT_CHARACTERISTICS)),)
        LOCAL_PACKAGE_NAME := com.google.android.pano.packageinstaller
else
        LOCAL_PACKAGE_NAME := com.google.android.packageinstaller
        LOCAL_PRIVILEGED_MODULE := true
endif

GAPPS_LOCAL_OVERRIDES_PACKAGES := PackageInstaller

include $(BUILD_GAPPS_PREBUILT_APK)
