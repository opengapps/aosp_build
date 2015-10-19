# Auto-generated Makefile from OpenGapps. Do not modify.
LOCAL_PATH := .
include $(CLEAR_VARS)
LOCAL_MODULE := FaceLock
LOCAL_PACKAGE_NAME := com.android.facelock
LOCAL_MODULE_PATH := $(PRODUCT_OUT)/system/app
LOCAL_SHARED_LIBRARIES := libfilterpack_facedetect

include $(BUILD_GAPPS_PREBUILT_APK)

include $(CLEAR_VARS)
LOCAL_MODULE := libfilterpack_facedetect
LOCAL_SRC_FILES := $(GAPPS_SOURCES_PATH)/arm/lib/libfilterpack_facedetect.so

include $(BUILD_GAPPS_PREBUILT_SHARED_LIBRARY)