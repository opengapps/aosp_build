LOCAL_PATH := .
include $(CLEAR_VARS)
LOCAL_MODULE := GoogleTTS
LOCAL_PACKAGE_NAME := com.google.android.tts

ifneq ($(filter $(TARGET_GAPPS_VARIANT),stock),) # overwrite if stock/super
LOCAL_OVERRIDES_PACKAGES := PicoTts
endif

include $(BUILD_GAPPS_PREBUILT_APK)
