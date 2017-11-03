# this file is explicitly included by opengapps-packages.mk, but it
# also gets automatically included by the aosp build system.  To
# prevent the defines below from being automatically set even for
# devices that do not have opengapps configured, we use an "ifneq"
# guard.  Alternatively, we could rename this file to something like
# "defines.mk".
ifneq ($(GAPPS_VARIANT),)

define get-allowed-api-levels
$(shell seq 1 "$(PLATFORM_SDK_VERSION)")
endef

define get-allowed-api-levels-regex
($(call subst,,|,$(call get-allowed-api-levels)))
endef

define find-apk-for-pkg
$(shell "$(GAPPS_BUILD_SYSTEM_PATH)/find_apk.sh" "$(GAPPS_SOURCES_PATH)" "$(PLATFORM_SDK_VERSION)" "$(PRODUCT_AAPT_PREF_CONFIG)" "$(2)" "$(1)" "$(GAPPS_FORCE_MATCHING_DPI)" "$(GAPPS_AAPT_PATH)")
endef

define get-lib-search-path
$(if $(filter arm,$(1)),lib/armeabi*/*,lib/$(1)*/*)
endef

define find-libs-in-apk
$(addprefix @,$(shell zipinfo -1 "$(2)" | grep "$(call get-lib-search-path, $(1))" | grep -v -E "*/crazy.*"))
endef

define get-gapps-variant
$(strip \
$(if $(filter pico, $(1)),pico) \
$(if $(filter nano, $(1)),pico nano) \
$(if $(filter tvstock,$(1)),tvstock) \
$(if $(filter micro,$(1)),pico nano micro) \
$(if $(filter mini, $(1)),pico nano micro mini) \
$(if $(filter full, $(1)),pico nano micro mini full) \
$(if $(filter stock,$(1)),pico nano micro mini full stock) \
$(if $(filter super,$(1)),pico nano micro mini full stock super) \
)
endef

define gapps-copy-to-system
$(shell python "$(GAPPS_BUILD_SYSTEM_PATH)/copy_files.py" "$(GAPPS_SOURCES_PATH)/$(1)/" "$(2)" "$(PLATFORM_SDK_VERSION)")
endef

define _gapps-find-lib-alternatives
$(foreach F,$(call get-allowed-api-levels),$(join $(join $(1)/,$F)/,$(2)))
endef

define gapps-find-lib-for-arch
$(join $(GAPPS_SOURCES_PATH)/,$(shell cd "$(GAPPS_SOURCES_PATH)"; \
	find -L $(call _gapps-find-lib-alternatives,$(join $(1)/,$(2)),$(3)) 2>/dev/null | tail -n1))
endef

define gapps-find-lib-for-kitkat
$(join $(GAPPS_SOURCES_PATH)/,$(shell cd "$(GAPPS_SOURCES_PATH)"; \
	find -L $(join arm/lib/19/lib_from_app/,$(1)) 2>/dev/null | tail -n1))
endef

endif
