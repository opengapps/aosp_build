include $(GAPPS_FILES)

PRODUCT_PACKAGES += GoogleBackupTransport \
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

ifneq ($(filter $(GAPPS_VARIANT),nano),) # require at least nano
PRODUCT_PACKAGES += FaceLock \
                    Velvet

ifneq ($(filter $(GAPPS_VARIANT),micro),) # require at least micro
PRODUCT_PACKAGES += CalendarGooglePrebuilt \
                    PrebuiltExchange3Google \
                    PrebuiltGmail \
                    GoogleHome \
                    GoogleTTS

ifneq ($(filter $(GAPPS_VARIANT),mini),) # require at least mini
PRODUCT_PACKAGES += GoogleHome \
                    GoogleTTS \
                    PrebuiltDeskClockGoogle \
                    PlusOne \
                    Hangouts \
                    Maps \
                    Photos \
                    YouTube

ifneq ($(filter $(GAPPS_VARIANT),full),) # require at least full
PRODUCT_PACKAGES += Books \
                    Chrome \
                    CloudPrint2 \
                    EditorsDocs \
                    Drive \
                    GoogleEars \
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

ifneq ($(filter $(GAPPS_VARIANT),stock),) # require at least stock
PRODUCT_PACKAGES += GoogleCamera \
                    LatinImeGoogle \
                    PrebuiltBugle

ifneq ($(filter $(GAPPS_VARIANT),super),)
PRODUCT_PACKAGES += AndroidForWork \
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
