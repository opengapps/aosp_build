#!/bin/bash

# Copied from opengapps inc.buildhelper.sh
getsourceforapi() {
  #this functions finds the highest available acceptable api level for the given architeture
  if ! stat --printf='' "$SOURCES/$2/"*"app/$1" 2>/dev/null; then
    return 1 #appname is not there, error!?
  fi
  appname="$1"
  sourceapk=""
  OLDIFS="$IFS"
  IFS="
"  #We set IFS to newline here so that spaces can survive the for loop
  #sed copies filename to the beginning, to compare version, and later we remove it with cut
  for foundapk in $(find $SOURCES/$2/*app/$1 -iname '*.apk' | sed 's!.*/\(.*\)!\1/&!' | sort -r -t/ -k1,1 | cut -d/ -f2-); do
    founddpipath="$(dirname "$foundapk")"
    dpi="$(basename "$founddpipath")"
    if [[ "$dpi" = "nodpi" || "$dpi" = *"$3"* ]]; then
      foundpath="$(dirname "$founddpipath")"
      api="$(basename "$foundpath")"
      if [ "$api" -le "$API" ]; then
        sourceapk="$foundapk"
        break;
      fi
    fi
  done
  IFS="$OLDIFS"
  if [ -z "$sourceapk" ]; then
    echo "WARNING: No APK found compatible with API level $API for package $appname on $2" >&2
    return 1 #error
  fi
  #$sourceapk and $api have the useful returnvalues
  return 0 #return that it was a success
}

getdpivalue() {
case "$1" in
"xxxhdpi")
dpivalue="640";
    ;;
"xxhdpi")
dpivalue="480";
    ;;
"xhdpi")
dpivalue="320";
    ;;
"hdpi")
dpivalue="240";
    ;;
"mdpi")
dpivalue="160";
    ;;
"ldpi")
dpivalue="120";
    ;;
*)
return 1;
    ;;
esac

return 0;
}

SOURCES="$1"
API="$2"
DPI="$3"
PACKAGE_NAME="$4"
ARCH="$5"

if getdpivalue "$DPI"; then
  if getsourceforapi "$PACKAGE_NAME" "$ARCH" "$dpivalue"; then
    echo "$sourceapk"
  else
    exit 1
  fi
elif getsourceforapi "$PACKAGE_NAME" "$ARCH" "nodpi"; then
  echo "$sourceapk"
else
  exit 1
fi