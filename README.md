# OpenGApps AOSP based build system

### Disclaimer
1. *Use this at your own risk.* Cyanogenmod received a cease and desist letter from Google when they included Google Apps in their ROM. See: [A Note on Google Apps for Android](http://android-developers.blogspot.com/2009/09/note-on-google-apps-for-android.html)
2. While this project places code in `vendor/google/build`, **This project is in no way affiliated with, sponsored by, or related to Google.** Placement of code in `vendor/google/build` is only done because it is required by the AOSP build process (more on that later).

## Getting started
**1. Add the build system, and the wanted sources to your manifest.**

Create the file `${ANDROID_BUILD_TOP}/.repo/local_manifests/opengapps.xml` (you might have to create the `local_manifests` folder first) with the following content:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <remote name="opengapps" fetch="https://github.com/opengapps/" />
  <project path="vendor/google/build" name="aosp_build" revision="master" remote="opengapps" />
  <project path="vendor/opengapps/sources/all" name="all" clone-depth="1" revision="master" remote="opengapps" />
  <!-- If you need other/additional targets, follow the same template: -->
  <project path="vendor/opengapps/sources/arm" name="arm" clone-depth="1" revision="master" remote="opengapps" />
</manifest>
```

**2. Set the desired OpenGapps variant**

In your `device/manufacturer/product/device.mk` file, in the beginning, add:
```makefile
GAPPS_VARIANT := <variant>
```

where `<variant>` is one of the [package types](https://github.com/opengapps/opengapps/wiki/Package-Comparison) in lowercase. E.g:

```
GAPPS_VARIANT := stock
```

**3. Include the opengapps-packages.mk file**

The `opengapps-packages.mk` file will make the Android build system build the necessary `PRODUCT_PACKAGES`, and include the necessary `PRODUCT_COPY_FILES`.

In `device/manufacturer/product/device.mk` file, towards the end, add:
```makefile
$(call inherit-product, vendor/google/build/opengapps-packages.mk)
```

**4. Build Android**

## Customizations
### Adding extra packages
You can add packages from versions higher then your set version. E.g. if you want to include `Chrome`, but you use `GAPPS_VARIANT:=micro`

In your `device/manufacturer/product/device.mk` just add, for example:

```
PRODUCT_PACKAGES += Chrome
```

This uses the module name. You can find the module name for a package by checking `vendor/google/build/modules/` and look at the `LOCAL_MODULE` value.

### DEX pre-optimization
It is possible to build Android with dex preoptimization. This results in a quicker boot time, at the cost of additional storage used on `/system`.

This is normally done by setting the value:
```
WITH_DEXPREOPT := true
```

in `BoardConfig.mk`. This will, by default, if set to true, also enable DEX Preoptimization for Google Apps.

You can disable this entirely by setting:
```
DONT_DEXPREOPT_PREBUILTS := true
```

## How it works
The OpenGApps AOSP based build system is placed in `vendor/google/build` and includes a file called `config.mk`. This is loaded by the AOSP build system very early, and allows us to define the necessary "functions" and build targets.

in `build/core/main.mk`:
```
# Include the google-specific config
-include vendor/google/build/config.mk
```

We use this hook to define two targets:
```
BUILD_GAPPS_PREBUILT_APK # - for apps
BUILD_GAPPS_PREBUILT_SHARED_LIBRARY # - for shared libraries
```

These use the already existing AOSP build infrastructure for prebuilt APKs and SHARED_LIBRARYs, but removes a lot of the boilerplate.

These two targets take care of locating the correct APK/libraries in an architecture-independent way. The AOSP based build system already prioritizes SoC architecture. E.g. if it finds an apk in `sources/arm64` and `sources/arm`, it will automatically prioritize `sources/arm64`.

The APK target will also scan the APK for any libraries, and if it finds libraries it will get the AOSP build system to automatically extract them and place them at the expected place.

## Caveats
### Some modules are missing overrides
With reference to the [package comparison](https://github.com/opengapps/opengapps/wiki/Package-Comparison), currently only package overrides has been setup for a `GAPPS_VARIANT` of `micro` or lower, + `Chrome`.

Pull requests to add package overrides for more modules is welcome. See `modules/Chrome/Android.mk` for an example.

### This has currently only been tested on a 5.1 ARM based device
Your milage may vary.

