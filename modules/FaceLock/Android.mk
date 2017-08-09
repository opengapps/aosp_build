# libfacelock_jni.so was renamed to libfacenet.so in Nougat+
ifeq ($(filter $(call get-allowed-api-levels),24),)
FACELOCK_JNI_NAME := libfacelock_jni
else
FACELOCK_JNI_NAME := libfacenet
endif

LOCAL_PATH := .
include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE := FaceLock
LOCAL_PACKAGE_NAME := com.android.facelock
LOCAL_SHARED_LIBRARIES := libfilterpack_facedetect $(FACELOCK_JNI_NAME) libfrsdk
include $(BUILD_GAPPS_PREBUILT_APK)

include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE := libfilterpack_facedetect
include $(BUILD_GAPPS_PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE := $(FACELOCK_JNI_NAME)
include $(BUILD_GAPPS_PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)
include $(GAPPS_CLEAR_VARS)
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE := libfrsdk
GAPPS_IS_VENDOR_LIB := true
include $(BUILD_GAPPS_PREBUILT_SHARED_LIBRARY)

# Cleanup temp variable
FACELOCK_JNI_NAME :=
