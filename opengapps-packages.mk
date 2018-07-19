include vendor/opengapps/build/core/definitions.mk
include vendor/opengapps/build/config.mk
include vendor/opengapps/build/opengapps-files.mk

# the logic here roughly corresponds to what is done in
# installer.sh from the opengapps install zips.

### begin installer.sh variables

# the variables below are used to construct a list of modules to
# install.  names prefixed with xxx do not correspond to modules in
# aosp_build -- they are handle differently.

core_gapps_list := \
defaultetc \
defaultframework \
googlebackuptransport \
googlecontactssyncadapter \
googlefeedback \
googleonetimeinitializer \
googlepartnersetup \
gmscore \
gsfcore \
vending \
setupwizarddefault \
setupwizardtablet \
configupdater \
extservicesgoogle \
extsharedgoogle \
gmssetup \
androidplatformservices

super_gapps_list := \
dmagent \
earth \
gcs \
googlepay \
indic \
japanese \
korean \
pinyin \
projectfi \
street \
translate \
zhuyin \
carrierservices

stock_gapps_list := \
cameragoogle \
duo \
hangouts \
keyboardgoogle \
vrservice \
wallpapers \
contactsgoogle \
webviewgoogle \
dialergoogle \
pixellauncher \
printservicegoogle \
storagemanagergoogle \
pixelicons

full_gapps_list := \
books \
chrome \
cloudprint \
docs \
drive \
fitness \
googleplus \
keep \
movies \
music \
newsstand \
newswidget \
playgames \
sheets \
slides \
talkback

mini_gapps_list := \
clockgoogle \
maps \
messenger \
photos \
youtube \
calculatorgoogle \
taggoogle

micro_gapps_list := \
calendargoogle \
exchangegoogle \
gmail \
googlenow

nano_gapps_list := \
facedetect \
faceunlock \
search \
speech \
batteryusage

pico_gapps_list := \
calsync \
dialerframework \
googletts \
packageinstallergoogle

tvcore_gapps_list := \
configupdater \
googlebackuptransport \
googlecontactssync \
gsfcore \
notouch \
tvetc \
tvframework \
tvgmscore \
tvvending \
extservicesgoogle \
extsharedgoogle

tvstock_gapps_list := \
backdrop \
castreceiver \
leanbacklauncher \
livechannels \
overscan \
secondscreensetup \
secondscreenauthbridge \
talkback \
tvkeyboardgoogle \
tvmovies \
tvmusic \
tvpackageinstallergoogle \
tvplaygames \
tvremote \
tvsearch \
tvwidget \
tvyoutube \
tvwallpaper \
webviewgoogle \
packageinstallergoogle \
leanbackrecommendations \
setupwraith \
tvlauncher \
tvrecommendations

### end install.sh variables


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

ifneq ($(filter 23,$(call get-allowed-api-levels)),)
GAPPS_PRODUCT_PACKAGES += \
    GoogleTTS \
    GooglePackageInstaller
endif

ifneq ($(filter 24,$(call get-allowed-api-levels)),)
GAPPS_PRODUCT_PACKAGES += \
    PrebuiltGmsCoreInstantApps
endif

ifneq ($(filter 25,$(call get-allowed-api-levels)),)
GAPPS_PRODUCT_PACKAGES += \
    Turbo
endif

ifneq ($(filter 26,$(call get-allowed-api-levels)),)
GAPPS_PRODUCT_PACKAGES += \
    AndroidPlatformServices
endif

ifneq ($(filter nano,$(TARGET_GAPPS_VARIANT)),) # require at least nano
GAPPS_PRODUCT_PACKAGES += \
    FaceLock \
    Velvet

ifneq ($(filter micro,$(TARGET_GAPPS_VARIANT)),) # require at least micro
GAPPS_PRODUCT_PACKAGES += \
    CalendarGooglePrebuilt \
    PrebuiltExchange3Google \
    PrebuiltGmail \
    GoogleHome

ifneq ($(filter mini,$(TARGET_GAPPS_VARIANT)),) # require at least mini
GAPPS_PRODUCT_PACKAGES += \
    CalculatorGoogle \
    PrebuiltDeskClockGoogle \
    PlusOne \
    Hangouts \
    Maps \
    Photos \
    YouTube

ifneq ($(filter full,$(TARGET_GAPPS_VARIANT)),) # require at least full

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

ifneq ($(filter stock,$(TARGET_GAPPS_VARIANT)),) # require at least stock

GAPPS_FORCE_MMS_OVERRIDES := true
GAPPS_FORCE_WEBVIEW_OVERRIDES := true
GAPPS_PRODUCT_PACKAGES += \
    GoogleCamera \
    GoogleContacts \
    LatinImeGoogle \
    TagGoogle \
    GoogleVrCore

ifneq ($(filter 23,$(call get-allowed-api-levels)),)
GAPPS_FORCE_DIALER_OVERRIDES := true
endif
ifneq ($(filter 24,$(call get-allowed-api-levels)),)
GAPPS_PRODUCT_PACKAGES += \
    GooglePrintRecommendationService \
    GoogleExtServices \
    GoogleExtShared
endif

ifneq ($(filter super,$(TARGET_GAPPS_VARIANT)),)

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

# This needs to be at the end of standard files, but before the GAPPS_FORCE_* options,
# since those also affect DEVICE_PACKAGE_OVERLAYS. We don't want to exclude a package
# that also has an overlay, since that will make us use the overlay but not have the
# package. This can cause issues.
PRODUCT_PACKAGES += $(filter-out $(GAPPS_EXCLUDED_PACKAGES),$(GAPPS_PRODUCT_PACKAGES))

DEVICE_PACKAGE_OVERLAYS += \
    $(GAPPS_DEVICE_FILES_PATH)/overlay/pico

ifeq ($(GAPPS_FORCE_WEBVIEW_OVERRIDES),true)
# starting with nougat, use a different overlay
ifneq ($(filter 24,$(call get-allowed-api-levels)),)
DEVICE_PACKAGE_OVERLAYS += \
    $(GAPPS_DEVICE_FILES_PATH)/overlay/webview/24
else
DEVICE_PACKAGE_OVERLAYS += \
    $(GAPPS_DEVICE_FILES_PATH)/overlay/webview/21
endif
PRODUCT_PACKAGES += \
    WebViewGoogle
endif

ifeq ($(GAPPS_FORCE_BROWSER_OVERRIDES),true)
ifneq ($(filter 23,$(call get-allowed-api-levels)),)
DEVICE_PACKAGE_OVERLAYS += \
    $(GAPPS_DEVICE_FILES_PATH)/overlay/browser
endif
PRODUCT_PACKAGES += \
    Chrome
endif

ifeq ($(GAPPS_FORCE_DIALER_OVERRIDES),true)
ifneq ($(filter 23,$(call get-allowed-api-levels)),)
DEVICE_PACKAGE_OVERLAYS += \
    $(GAPPS_DEVICE_FILES_PATH)/overlay/dialer

PRODUCT_PACKAGES += \
    GoogleDialer
endif
endif

ifeq ($(GAPPS_FORCE_MMS_OVERRIDES),true)
DEVICE_PACKAGE_OVERLAYS += \
    $(GAPPS_DEVICE_FILES_PATH)/overlay/mms

PRODUCT_PACKAGES += \
    PrebuiltBugle
endif

ifeq ($(GAPPS_FORCE_PIXEL_LAUNCHER),true)

ifneq ($(filter 26,$(call get-allowed-api-levels)),)
DEVICE_PACKAGE_OVERLAYS += \
    $(GAPPS_DEVICE_FILES_PATH)/overlay/pixelicons/26
else ifneq ($(filter 25,$(call get-allowed-api-levels)),)
DEVICE_PACKAGE_OVERLAYS += \
    $(GAPPS_DEVICE_FILES_PATH)/overlay/pixelicons/25
endif

ifneq ($(filter 25,$(call get-allowed-api-levels)),)
PRODUCT_PACKAGES += \
    PixelLauncherIcons
endif

PRODUCT_PACKAGES += \
    PixelLauncher \
    Wallpapers
endif
