LOCAL_PATH := .
include $(CLEAR_VARS)
LOCAL_MODULE := FaceLock
LOCAL_PACKAGE_NAME := com.android.facelock
LOCAL_MODULE_PATH := $(PRODUCT_OUT)/system/app
LOCAL_SHARED_LIBRARIES := libfilterpack_facedetect libfacelock_jni libfrsdk
include $(BUILD_GAPPS_PREBUILT_APK)

include $(CLEAR_VARS)
LOCAL_MODULE := libfilterpack_facedetect
include $(BUILD_GAPPS_PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libfacelock_jni
include $(BUILD_GAPPS_PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libfrsdk
GAPPS_IS_VENDOR_LIB := true
include $(BUILD_GAPPS_PREBUILT_SHARED_LIBRARY)
