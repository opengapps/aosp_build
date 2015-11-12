LOCAL_PATH := .
include $(CLEAR_VARS)
LOCAL_MODULE := FaceLock
LOCAL_PACKAGE_NAME := com.android.facelock
LOCAL_MODULE_PATH := $(PRODUCT_OUT)/system/app
LOCAL_SHARED_LIBRARIES := libfilterpack_facedetect libfacelock_jni libfrsdk

include $(BUILD_GAPPS_PREBUILT_APK)
include $(CLEAR_VARS)
LOCAL_MODULE := libfilterpack_facedetect
LOCAL_SRC_FILES := $(GAPPS_SOURCES_PATH)/arm/lib/libfilterpack_facedetect.so

include $(BUILD_GAPPS_PREBUILT_SHARED_LIBRARY)
include $(CLEAR_VARS)
LOCAL_MODULE := libfacelock_jni
LOCAL_SRC_FILES := $(GAPPS_SOURCES_PATH)/arm/lib/libfacelock_jni.so

include $(BUILD_GAPPS_PREBUILT_SHARED_LIBRARY)
include $(CLEAR_VARS)
LOCAL_MODULE := libfrsdk
LOCAL_SRC_FILES := $(GAPPS_SOURCES_PATH)/arm/vendor/lib/libfrsdk.so
GAPPS_MODULE_PATH := TARGET_OUT_VENDOR_SHARED_LIBRARIES

include $(BUILD_GAPPS_PREBUILT_SHARED_LIBRARY)
