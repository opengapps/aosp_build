# Always needed
PRODUCT_COPY_FILES += $(call gapps-copy-to-system, all, etc framework)

# Pico and higher
ifneq ($(filter $(TARGET_GAPPS_VARIANT),pico),)
PRODUCT_COPY_FILES += $(call gapps-copy-to-system, all, vendor/pittpatt usr/srec)
endif
