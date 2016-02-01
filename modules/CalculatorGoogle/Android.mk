LOCAL_PATH := .
include $(CLEAR_VARS)
LOCAL_MODULE := CalculatorGoogle
LOCAL_PACKAGE_NAME := com.google.android.calculator

ifneq ($(filter $(TARGET_GAPPS_VARIANT),mini),) # overwrite if mini/full/stock/super
LOCAL_OVERRIDES_PACKAGES := Calculator ExactCalculator
endif

include $(BUILD_GAPPS_PREBUILT_APK)
