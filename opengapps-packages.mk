include vendor/google/build/config.mk
include $(GAPPS_FILES)

DEVICE_PACKAGE_OVERLAYS += \
    $(GAPPS_DEVICE_FILES_PATH)/overlay/pico

GAPPS_PRODUCT_PACKAGES += \
    GoogleBackupTransport \
    GoogleContactsSyncAdapter \
    GoogleFeedback \
    GoogleOneTimeInitializer \
    GooglePartnerSetup \
    PrebuiltGmsCore \
    GoogleServicesFramework \
    GoogleLoginService \
    SetupWizard \
    Phonesky \
    GoogleCalendarSyncAdapter

ifneq ($(filter $(call get-allowed-api-levels),23),)
GAPPS_PRODUCT_PACKAGES += \
    GoogleTTS \
    GooglePackageInstaller
endif

ifneq ($(filter $(TARGET_GAPPS_VARIANT),nano),) # require at least nano
GAPPS_PRODUCT_PACKAGES += \
    FaceLock \
    HotwordEnrollment \
    Velvet

ifneq ($(filter $(TARGET_GAPPS_VARIANT),micro),) # require at least micro
GAPPS_PRODUCT_PACKAGES += \
    CalendarGooglePrebuilt \
    PrebuiltExchange3Google \
    PrebuiltGmail \
    GoogleHome

ifeq ($(filter $(call get-allowed-api-levels),23),)
GAPPS_PRODUCT_PACKAGES += \
    GoogleTTS
endif

ifneq ($(filter $(TARGET_GAPPS_VARIANT),mini),) # require at least mini
GAPPS_PRODUCT_PACKAGES += \
    CalculatorGoogle \
    PrebuiltDeskClockGoogle \
    PlusOne \
    Hangouts \
    Maps \
    Photos \
    YouTube

ifneq ($(filter $(TARGET_GAPPS_VARIANT),full),) # require at least full

GAPPS_FORCE_BROWSER_OVERRIDES := true
GAPPS_PRODUCT_PACKAGES += \
    Books \
    CloudPrint2 \
    EditorsDocs \
    Drive \
    FitnessPrebuilt \
    PrebuiltKeep \
    Videos \
    Music2 \
    Newsstand \
    PrebuiltNewsWeather \
    PlayGames \
    EditorsSheets \
    EditorsSlides \
    talkback

ifneq ($(filter $(TARGET_GAPPS_VARIANT),stock),) # require at least stock

GAPPS_FORCE_MMS_OVERRIDES := true
GAPPS_FORCE_WEBVIEW_OVERRIDES := true
GAPPS_PRODUCT_PACKAGES += \
    GoogleCamera \
    GoogleContacts \
    LatinImeGoogle \
    TagGoogle \
    GoogleVrCore

ifneq ($(filter $(call get-allowed-api-levels),23),)
GAPPS_FORCE_DIALER_OVERRIDES := true
endif
ifneq ($(filter $(call get-allowed-api-levels),24),)
GAPPS_PRODUCT_PACKAGES += \
    GooglePrintRecommendationService \
    GoogleExtServices \
    GoogleExtShared
endif

ifneq ($(filter $(TARGET_GAPPS_VARIANT),super),)

GAPPS_PRODUCT_PACKAGES += \
    Wallet \
    DMAgent \
    GoogleEarth \
    GCS \
    GoogleHindiIME \
    GoogleJapaneseInput \
    KoreanIME \
    GooglePinyinIME \
    Tycho \
    Street \
    TranslatePrebuilt \
    GoogleZhuyinIME

endif # end super
endif # end stock
endif # end full
endif # end mini
endif # end micro
endif # end nano

ifeq ($(GAPPS_FORCE_WEBVIEW_OVERRIDES),true)
ifneq ($(filter-out $(call get-allowed-api-levels),24),)
DEVICE_PACKAGE_OVERLAYS += \
    $(GAPPS_DEVICE_FILES_PATH)/overlay/webview/21
else
DEVICE_PACKAGE_OVERLAYS += \
    $(GAPPS_DEVICE_FILES_PATH)/overlay/webview/24
endif
GAPPS_PRODUCT_PACKAGES += \
    WebViewGoogle
endif

ifeq ($(GAPPS_FORCE_BROWSER_OVERRIDES),true)
ifneq ($(filter $(call get-allowed-api-levels),23),)
DEVICE_PACKAGE_OVERLAYS += \
    $(GAPPS_DEVICE_FILES_PATH)/overlay/browser
endif
GAPPS_PRODUCT_PACKAGES += \
    Chrome
endif

ifneq ($(filter $(call get-allowed-api-levels),23),)
ifeq ($(GAPPS_FORCE_DIALER_OVERRIDES),true)
DEVICE_PACKAGE_OVERLAYS += \
    $(GAPPS_DEVICE_FILES_PATH)/overlay/dialer

GAPPS_PRODUCT_PACKAGES += \
    GoogleDialer
endif
endif

ifeq ($(GAPPS_FORCE_MMS_OVERRIDES),true)
DEVICE_PACKAGE_OVERLAYS += \
    $(GAPPS_DEVICE_FILES_PATH)/overlay/mms

GAPPS_PRODUCT_PACKAGES += \
    PrebuiltBugle
endif

ifeq ($(GAPPS_FORCE_PIXEL_HOME),true)
GAPPS_EXCLUDED_PACKAGES += \
    GoogleHome

GAPPS_PRODUCT_PACKAGES += \
    PixelHome \
    PixelHomeIcons \
    Wallpaper        
endif

PRODUCT_PACKAGES += $(filter-out $(GAPPS_EXCLUDED_PACKAGES),$(GAPPS_PRODUCT_PACKAGES))
