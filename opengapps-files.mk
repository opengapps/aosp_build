# Always needed
PRODUCT_COPY_FILES += $(call gapps-copy-to-system,all,etc framework)

# Pico and higher
ifneq ($(filter $(TARGET_GAPPS_VARIANT),pico),)
# vendor/pittpatt seems to be removed on N+ (so only copy it to older than N)
ifeq ($(filter $(call-get-allowed-api-levels),24),)
  PRODUCT_COPY_FILES += $(call gapps-copy-to-system,all,vendor/pittpatt)
endif
  PRODUCT_COPY_FILES += $(call gapps-copy-to-system,all,usr/srec)
endif
