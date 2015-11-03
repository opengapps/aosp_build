GAPPS_SOURCES_ALL_PATH := $(GAPPS_SOURCES_PATH)/all

# Always needed
PRODUCT_COPY_FILES += $(GAPPS_SOURCES_ALL_PATH)/etc/permissions/com.google.widevine.software.drm.xml:system/etc/permissions/com.google.widevine.software.drm.xml \
                      $(GAPPS_SOURCES_ALL_PATH)/etc/permissions/com.google.android.maps.xml:system/etc/permissions/com.google.android.maps.xml \
                      $(GAPPS_SOURCES_ALL_PATH)/etc/permissions/com.google.android.media.effects.xml:system/etc/permissions/com.google.android.media.effects.xml \
                      $(GAPPS_SOURCES_ALL_PATH)/etc/preferred-apps/google.xml:system/etc/preferred-apps/google.xml \
                      $(GAPPS_SOURCES_ALL_PATH)/framework/com.google.widevine.software.drm.jar:system/framework/com.google.widevine.software.drm.jar \
                      $(GAPPS_SOURCES_ALL_PATH)/framework/com.google.android.maps.jar:system/framework/com.google.android.maps.jar \
                      $(GAPPS_SOURCES_ALL_PATH)/framework/com.google.android.dialer.support.jar:system/framework/com.google.android.dialer.support.jar \
                      $(GAPPS_SOURCES_ALL_PATH)/framework/com.google.android.media.effects.jar:system/framework/com.google.android.media.effects.jar

# Pico and higher
ifneq ($(filter $(GAPPS_VARIANT),pico),)
PRODUCT_COPY_FILES += \
                      $(GAPPS_SOURCES_ALL_PATH)/vendor/pittpatt/models/detection/yaw_roll_face_detectors.7.1/pose-y-r.8.1.bin:system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.7.1/pose-y-r.8.1.bin \
                      $(GAPPS_SOURCES_ALL_PATH)/vendor/pittpatt/models/detection/yaw_roll_face_detectors.7.1/pose-r.8.1.bin:system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.7.1/pose-r.8.1.bin \
                      $(GAPPS_SOURCES_ALL_PATH)/vendor/pittpatt/models/detection/yaw_roll_face_detectors.7.1/head-y0-yi45-p0-pi45-r0-ri30.4a-v24-tree7-2-wmd.bin:system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.7.1/head-y0-yi45-p0-pi45-r0-ri30.4a-v24-tree7-2-wmd.bin \
                      $(GAPPS_SOURCES_ALL_PATH)/vendor/pittpatt/models/detection/yaw_roll_face_detectors.7.1/head-y0-yi45-p0-pi45-rp30-ri30.5-v24-tree7-2-wmd.bin:system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.7.1/head-y0-yi45-p0-pi45-rp30-ri30.5-v24-tree7-2-wmd.bin \
                      $(GAPPS_SOURCES_ALL_PATH)/vendor/pittpatt/models/detection/yaw_roll_face_detectors.7.1/head-y0-yi45-p0-pi45-rn30-ri30.5-v24-tree7-2-wmd.bin:system/vendor/pittpatt/models/detection/yaw_roll_face_detectors.7.1/head-y0-yi45-p0-pi45-rn30-ri30.5-v24-tree7-2-wmd.bin \
                      $(GAPPS_SOURCES_ALL_PATH)/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.8/nose_base-y0-yi45-p0-pi45-r0-ri20.lg_32-tree7-wmd.bin:system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.8/nose_base-y0-yi45-p0-pi45-r0-ri20.lg_32-tree7-wmd.bin \
                      $(GAPPS_SOURCES_ALL_PATH)/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.8/right_eye-y0-yi45-p0-pi45-r0-ri20.lg_32-3-tree7-wmd.bin:system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.8/right_eye-y0-yi45-p0-pi45-r0-ri20.lg_32-3-tree7-wmd.bin \
                      $(GAPPS_SOURCES_ALL_PATH)/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.8/left_eye-y0-yi45-p0-pi45-r0-ri20.lg_32-tree7-wmd.bin:system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.8/left_eye-y0-yi45-p0-pi45-r0-ri20.lg_32-tree7-wmd.bin \
                      $(GAPPS_SOURCES_ALL_PATH)/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.8/landmark_group_meta_data.bin:system/vendor/pittpatt/models/detection/multi_pose_face_landmark_detectors.8/landmark_group_meta_data.bin \
                      $(GAPPS_SOURCES_ALL_PATH)/vendor/pittpatt/models/recognition/face.face.y0-y0-71-N-tree_7-wmd.bin:system/vendor/pittpatt/models/recognition/face.face.y0-y0-71-N-tree_7-wmd.bin \
                      \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/dict:system/usr/srec/en-US/dict \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/offensive_word_normalizer.mfar:system/usr/srec/en-US/offensive_word_normalizer.mfar \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/rescoring.fst.louds:system/usr/srec/en-US/rescoring.fst.louds \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/CONTACTS.syms:system/usr/srec/en-US/CONTACTS.syms \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/voice_actions_compiler.config:system/usr/srec/en-US/voice_actions_compiler.config \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/hmm_symbols:system/usr/srec/en-US/hmm_symbols \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/lstm_model.uint8.data:system/usr/srec/en-US/lstm_model.uint8.data \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/CLG.prewalk.fst:system/usr/srec/en-US/CLG.prewalk.fst \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/normalizer.mfar:system/usr/srec/en-US/normalizer.mfar \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/wordlist.syms:system/usr/srec/en-US/wordlist.syms \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/dist_belief:system/usr/srec/en-US/dist_belief \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/class_normalizer.mfar:system/usr/srec/en-US/class_normalizer.mfar \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/g2p_fst:system/usr/srec/en-US/g2p_fst \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/norm_fst:system/usr/srec/en-US/norm_fst \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/phonemes.syms:system/usr/srec/en-US/phonemes.syms \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/lexicon.U.fst:system/usr/srec/en-US/lexicon.U.fst \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/voice_actions.config:system/usr/srec/en-US/voice_actions.config \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/endpointer_voicesearch.config:system/usr/srec/en-US/endpointer_voicesearch.config \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/compile_grammar.config:system/usr/srec/en-US/compile_grammar.config \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/phonelist:system/usr/srec/en-US/phonelist \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/hmmlist:system/usr/srec/en-US/hmmlist \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/commands.abnf:system/usr/srec/en-US/commands.abnf \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/g2p.data:system/usr/srec/en-US/g2p.data \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/magic_mic.config:system/usr/srec/en-US/magic_mic.config \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/endpointer_dictation.config:system/usr/srec/en-US/endpointer_dictation.config \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/graphemes.syms:system/usr/srec/en-US/graphemes.syms \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/phonelist.syms:system/usr/srec/en-US/phonelist.syms \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/input_mean_std_dev:system/usr/srec/en-US/input_mean_std_dev \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/dictation.config:system/usr/srec/en-US/dictation.config \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/grammar.config:system/usr/srec/en-US/grammar.config \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/CONTACTS.fst:system/usr/srec/en-US/CONTACTS.fst \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/dnn:system/usr/srec/en-US/dnn \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/action.pumpkin:system/usr/srec/en-US/action.pumpkin \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/c_fst:system/usr/srec/en-US/c_fst \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/config.pumpkin:system/usr/srec/en-US/config.pumpkin \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/endpointer_model.mmap:system/usr/srec/en-US/endpointer_model.mmap \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/semantics.pumpkin:system/usr/srec/en-US/semantics.pumpkin \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/metadata:system/usr/srec/en-US/metadata \
                      $(GAPPS_SOURCES_ALL_PATH)/usr/srec/en-US/contacts.abnf:system/usr/srec/en-US/contacts.abnf
endif
