LOCAL_PATH := .
include $(CLEAR_VARS)
LOCAL_MODULE := GooglePinyinIME
LOCAL_PACKAGE_NAME := com.google.android.inputmethod.pinyin
LOCAL_MODULE_PATH := $(PRODUCT_OUT)/system/app

include $(BUILD_GAPPS_PREBUILT_APK)
