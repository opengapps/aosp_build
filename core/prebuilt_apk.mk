LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED

LOCAL_SRC_FILES := $(call find-apk-for-pkg,all,$(LOCAL_PACKAGE_NAME))

ifdef LOCAL_SRC_FILES
  LOCAL_PREBUILT_JNI_LIBS := $(call find-libs-in-apk,$(TARGET_ARCH),$(LOCAL_SRC_FILES))
else
  LOCAL_SRC_FILES := $(call find-apk-for-pkg,$(TARGET_ARCH),$(LOCAL_PACKAGE_NAME))

  ifdef LOCAL_SRC_FILES
    LOCAL_PREBUILT_JNI_LIBS_$(TARGET_ARCH) := $(call find-libs-in-apk,$(TARGET_ARCH),$(LOCAL_SRC_FILES))
  else
    ifdef TARGET_2ND_ARCH
      LOCAL_SRC_FILES := $(call find-apk-for-pkg,$(TARGET_2ND_ARCH),$(LOCAL_PACKAGE_NAME))
      ifdef LOCAL_SRC_FILES
        LOCAL_PREBUILT_JNI_LIBS_$(TARGET_2ND_ARCH) := $(call find-libs-in-apk,$(TARGET_2ND_ARCH),$(LOCAL_SRC_FILES))
      endif
    endif
  endif
endif

include $(BUILD_PREBUILT)
