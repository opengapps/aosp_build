LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED

CURRENT_PATH := $(GAPPS_DEVICE_FILES_PATH)/modules/$(LOCAL_MODULE)

# Override packages from GAPPS_LOCAL_OVERRIDES_PACKAGES only when required.
# If a package should NOT in any case be installed, add it directly to LOCAL_OVERRIDES_PACKAGES instead.
ifneq ($(GAPPS_LOCAL_OVERRIDES_PACKAGES),)
  ifeq ($(filter $(LOCAL_MODULE),$(GAPPS_BYPASS_PACKAGE_OVERRIDES)),)
    ifeq ($(GAPPS_FORCE_PACKAGE_OVERRIDES),true)
      LOCAL_OVERRIDES_PACKAGES += $(GAPPS_LOCAL_OVERRIDES_PACKAGES)
    else ifeq ($(GAPPS_LOCAL_OVERRIDES_MIN_VARIANT),)
      LOCAL_OVERRIDES_PACKAGES += $(GAPPS_LOCAL_OVERRIDES_PACKAGES)
    else ifneq ($(filter $(GAPPS_LOCAL_OVERRIDES_MIN_VARIANT),$(TARGET_GAPPS_VARIANT)),)
      LOCAL_OVERRIDES_PACKAGES += $(GAPPS_LOCAL_OVERRIDES_PACKAGES)
    else ifneq ($(filter $(LOCAL_MODULE),$(GAPPS_PACKAGE_OVERRIDES)),)
      LOCAL_OVERRIDES_PACKAGES += $(GAPPS_LOCAL_OVERRIDES_PACKAGES)
    endif
  endif
endif

LOCAL_SRC_FILES := $(call find-apk-for-pkg,all,$(LOCAL_PACKAGE_NAME))

ifdef LOCAL_SRC_FILES
  LOCAL_PREBUILT_JNI_LIBS := $(call find-libs-in-apk,$(TARGET_ARCH),$(LOCAL_SRC_FILES))
else
  LOCAL_SRC_FILES := $(call find-apk-for-pkg,$(TARGET_ARCH),$(LOCAL_PACKAGE_NAME))
  ifdef LOCAL_SRC_FILES
    ifeq ($(filter 21,$(call get-allowed-api-levels)),)
      # only kitkat
      ifneq ($(call find-libs-in-apk,$(TARGET_ARCH),$(LOCAL_SRC_FILES)),)
        LOCAL_SHARED_LIBRARIES := $(notdir $(basename $(shell zipinfo -1 "$(LOCAL_SRC_FILES)" "$(call get-lib-search-path, $(TARGET_ARCH))" -x lib/*/crazy/* 2>/dev/null)))
      endif
    else
      LOCAL_PREBUILT_JNI_LIBS_$(TARGET_ARCH) := $(call find-libs-in-apk,$(TARGET_ARCH),$(LOCAL_SRC_FILES))
    endif
  else
    ifdef TARGET_2ND_ARCH
      LOCAL_SRC_FILES := $(call find-apk-for-pkg,$(TARGET_2ND_ARCH),$(LOCAL_PACKAGE_NAME))
      ifdef LOCAL_SRC_FILES
        LOCAL_MODULE_TARGET_ARCH := $(TARGET_2ND_ARCH)
        LOCAL_PREBUILT_JNI_LIBS_$(TARGET_2ND_ARCH) := $(call find-libs-in-apk,$(TARGET_2ND_ARCH),$(LOCAL_SRC_FILES))
      endif
    endif
  endif
endif

ifndef LOCAL_SRC_FILES
# the three calls to find-apk-for-pkg above all failed.
# emit an error if the module is in the set GAPPS_PRODUCT_PACKAGES - GAPPS_EXCLUDED_PACKAGES
ifneq (,$(filter $(LOCAL_MODULE),$(GAPPS_PRODUCT_PACKAGES)))
ifeq  (,$(filter $(LOCAL_MODULE),$(GAPPS_EXCLUDED_PACKAGES)))
  $(warning Unable to find an architecture compatible APK for package $(LOCAL_PACKAGE_NAME) defined in module $(LOCAL_MODULE).)
  $(warning You can try using GAPPS_EXCLUDED_PACKAGES += $(LOCAL_MODULE) to get past this error.)
  $(error Invalid build module: $(LOCAL_MODULE))
endif
endif
endif

include $(BUILD_PREBUILT)

# generate mk file of shared library for kitkat
ifdef LOCAL_SRC_FILES
  ifeq ($(filter 21,$(call get-allowed-api-levels)),)
    ifneq ($(call find-libs-in-apk,$(TARGET_ARCH),$(LOCAL_SRC_FILES)),)
      $(shell unzip -qqq -j -o "$(LOCAL_SRC_FILES)" "$(call get-lib-search-path, $(TARGET_ARCH))" -x lib/*/crazy/* -d "$(GAPPS_SOURCES_PATH)"/$(TARGET_ARCH)/lib/19/lib_from_app 2>/dev/null)
      LIBRARIES :=
      LIBRARIES := $(foreach L, $(LOCAL_SHARED_LIBRARIES), $(join $(LIBRARIES),$L))
      $(shell python "$(GAPPS_BUILD_SYSTEM_PATH)/mk_generator_for_kitkat.py" $(CURRENT_PATH) $(LIBRARIES) 2>/dev/null)
      include $(CURRENT_PATH)/SharedLibrary.mk
    endif
  endif
endif
