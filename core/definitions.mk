define get-allowed-api-levels
$(shell seq 1 $(PLATFORM_SDK_VERSION))
endef

define get-allowed-api-levels-regex
($(call subst, ,|,$(call get-allowed-api-levels)))
endef

define find-apk-for-pkg
$(shell $(GAPPS_BUILD_SYSTEM_PATH)/find_apk.sh "$(GAPPS_SOURCES_PATH)" $(PLATFORM_SDK_VERSION) $(2) $(1))
endef

define get-lib-search-path
$(if $(filter $(1),arm),lib/armeabi*/*,lib/$(1)*/*)
endef

define find-libs-in-apk
$(addprefix @,$(shell zipinfo -1 $(2) | grep "$(call get-lib-search-path, $(1))" | grep -v -E "*/crazy.*"))
endef

define get-gapps-variant
$(strip \
$(if $(filter $(1),pico),pico) \
$(if $(filter $(1),nano),pico nano) \
$(if $(filter $(1),micro),pico nano micro) \
$(if $(filter $(1),mini),pico nano micro mini) \
$(if $(filter $(1),full),pico nano micro mini full) \
$(if $(filter $(1),stock),pico nano micro mini full stock) \
$(if $(filter $(1),super),pico nano micro mini full stock super) \
)
endef

define gapps-all-files-under
$(patsubst ./%,%, \
	$(shell cd $(GAPPS_SOURCES_PATH); cd $(1); \
		find -L $(2) -type f -and -not -name ".*") \
)
endef

define gapps-copy-to-system
$(foreach F,$(call gapps-all-files-under, $(1), $(2)),$(join $(GAPPS_SOURCES_PATH)/,$(1))/$F:system/$F)
endef

BUILD_GAPPS_PREBUILT_APK := $(GAPPS_BUILD_SYSTEM_PATH)/prebuilt_apk.mk
BUILD_GAPPS_PREBUILT_SHARED_LIBRARY := $(GAPPS_BUILD_SYSTEM_PATH)/prebuilt_shared_library.mk
