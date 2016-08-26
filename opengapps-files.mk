# Always needed
PRODUCT_COPY_FILES += $(call gapps-copy-to-system,all,etc framework)

# Pico and higher
ifneq ($(filter $(TARGET_GAPPS_VARIANT),pico),)
  PRODUCT_COPY_FILES += $(call gapps-copy-to-system,all,usr/srec)

  # We don't want to modify system/vendor IF the device has a separate vendor partition
  # (e.g. N5X N6P)
  ifneq ($(TARGET_COPY_OUT_VENDOR),vendor)
    PRODUCT_COPY_FILES += $(call gapps-copy-to-system,all,vendor/pittpatt)
  endif
endif
