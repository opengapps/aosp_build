# OpenGApps AOSP based build system

### Disclaimer
1. **Use this at your own risk.** Cyanogenmod received a cease and desist letter from Google when they included Google Apps in their ROM. See: [A Note on Google Apps for Android](http://android-developers.blogspot.com/2009/09/note-on-google-apps-for-android.html)
2. **This project is in no way affiliated with, sponsored by, or related to Google.**

## Getting started
**1. Add the build system, and the wanted sources to your manifest.**

Find your manifest file (check inside `${ANDROID_BUILD_TOP}/.repo/manifests/`)
and add the following towards the end:
```xml
<remote name="opengapps" fetch="https://github.com/opengapps/"  />

<project path="vendor/opengapps/build" name="aosp_build" revision="master" remote="opengapps" />
<project path="vendor/opengapps/sources/all" name="all" clone-depth="1" revision="master" remote="opengapps" />

<!-- arm64 depends on arm -->
<project path="vendor/opengapps/sources/arm" name="arm" clone-depth="1" revision="master" remote="opengapps" />
<project path="vendor/opengapps/sources/arm64" name="arm64" clone-depth="1" revision="master" remote="opengapps" />

<project path="vendor/opengapps/sources/x86" name="x86" clone-depth="1" revision="master" remote="opengapps" />
<project path="vendor/opengapps/sources/x86_64" name="x86_64" clone-depth="1" revision="master" remote="opengapps" />
```

**2. Set the desired OpenGapps variant**

In your `device/manufacturer/product/device.mk` file, in the beginning, add:
```makefile
GAPPS_VARIANT := <variant>
```

where `<variant>` is one of the [package types](https://github.com/opengapps/opengapps/wiki/Package-Comparison) in lowercase. E.g:

```makefile
GAPPS_VARIANT := stock
```

**3. Include the opengapps-packages.mk file**

The `opengapps-packages.mk` file will make the Android build system build the necessary `PRODUCT_PACKAGES`, and include the necessary `PRODUCT_COPY_FILES`.

In `device/manufacturer/product/device.mk` file, towards the end, add:
```makefile
$(call inherit-product, vendor/opengapps/build/opengapps-packages.mk)
```

**4. Build Android**

## Customizations
### Adding extra packages
You can add packages from versions higher then your set version. E.g. if you want to include `Chrome`, but you use `GAPPS_VARIANT := micro`

In your `device/manufacturer/product/device.mk` just add, for example:

```makefile
GAPPS_PRODUCT_PACKAGES += Chrome
```

This uses the module name. You can find the module name for a package by checking `vendor/opengapps/build/modules/` and look at the `LOCAL_MODULE` value.

### Excluding packages
You can exclude certain packages from the list of packages associated with your selected OpenGapps variant. E.g. if you have `GAPPS_VARIANT := stock`
and want all those apps installed except for `Hangouts`, then in your `device/manufacturer/product/device.mk` just add:

```makefile
GAPPS_EXCLUDED_PACKAGES := Hangouts
```

### Force stock package overrides
You can force GApps packages to override the stock packages.
This can be defined in two ways inside `device/manufacturer/product/device.mk`.

For all package:

```makefile
GAPPS_FORCE_PACKAGE_OVERRIDES := true
```

If you want to include WebViewGoogle on a non-stock build you need:

```makefile
GAPPS_FORCE_WEBVIEW_OVERRIDES := true
```

If you want to include Messenger on a non-stock build you need:

```makefile
GAPPS_FORCE_MMS_OVERRIDES := true
```

If you want to include Google Dialer on a non-stock build you need:

```makefile
GAPPS_FORCE_DIALER_OVERRIDES := true
```

If you want to include Chrome on a non-full build you need:

```makefile
GAPPS_FORCE_BROWSER_OVERRIDES := true
```

PixelLauncher is the default launcher in Oreo builds (and newer); in
builds older than Oreo, the default launcher is GoogleNow.  If
desired, then you can force PixelLauncher to be used by setting the
following variable:

```makefile
GAPPS_FORCE_PIXEL_LAUNCHER := true
```

On a per-app basis, add the GApps package to `GAPPS_PACKAGE_OVERRIDES`.
Example:

```makefile
GAPPS_PACKAGE_OVERRIDES := Chrome
```

### Disable stock packages overrides
You can tell the GApps packages not to override the stock packages.
This can be defined inside `device/manufacturer/product/device.mk` by adding the GApps package to `GAPPS_BYPASS_PACKAGE_OVERRIDES`.
Example:

```makefile
GAPPS_BYPASS_PACKAGE_OVERRIDES := Chrome
```

### Force the system to get the correct DPI package for your device
By default, the latest package version will be selected with the closest DPI.
You can force the system to select either a matching DPI package or "nodpi" package even if it is not the latest version.

This can be defined inside `device/manufacturer/product/device.mk` using:

```makefile
GAPPS_FORCE_MATCHING_DPI := true
```

### DEX pre-optimization
It is possible to build Android with dex preoptimization. This results in a quicker boot time, at the cost of additional storage used on `/system`.

This is normally done by setting the value:
```makefile
WITH_DEXPREOPT := true
```

in `BoardConfig.mk`. This will, by default, if set to true, also enable DEX Preoptimization for Google Apps.

You can disable this entirely by setting:
```makefile
DONT_DEXPREOPT_PREBUILTS := true
```

## How it works

When building in an AOSP tree, the build system processes the file `device/manufacturer/product/device.mk` very early, which means that the file `vendor/opengapps/build/opengapps-packages.mk` is also processed very early.
This causes two special build "functions" (generic build rules) to be defined before any Android.mk files are read:

```makefile
BUILD_GAPPS_PREBUILT_APK # - for apps
BUILD_GAPPS_PREBUILT_SHARED_LIBRARY # - for shared libraries
```

The definitions use the already existing AOSP build infrastructure for prebuilt APKs and SHARED_LIBRARYs, but remove a lot of the boilerplate.

The build rules take care of locating the correct APK/libraries in an architecture-independent way. The AOSP based build system already prioritizes SoC architecture. E.g. if it finds an apk in `sources/arm64` and `sources/arm`, it will automatically prioritize `sources/arm64`.

The APK rule will also scan the APK for any libraries, and if it finds libraries it will get the AOSP build system to automatically extract them and place them at the expected place.

## Caveats
### Some modules are missing overrides
With reference to the [package comparison](https://github.com/opengapps/opengapps/wiki/Package-Comparison), currently only package overrides has been setup for a `GAPPS_VARIANT` of `micro` or lower, + `Chrome`.

Pull requests to add package overrides for more modules is welcome. See `modules/Chrome/Android.mk` for an example.

### Chrome on Lollipop requires an extra patch
Run these commands:
```bash
cd build
curl https://raw.githubusercontent.com/opengapps/aosp_build/master/patches/Lollipop/0001-Fix-Chrome.patch | git am -
```

(Patch only tested on 5.1.1 r37).
