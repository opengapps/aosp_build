#!/bin/bash

# Copied from opengapps inc.buildhelper.sh
getsourceforapi() {
  #this functions finds the highest available acceptable api level for the given architeture
  if ! stat --printf='' "$SOURCES/$2/"*"app/$1" 2>/dev/null; then
    return 1 #appname is not there, error!?
  fi
  appname="$3"
  sourceapks=""
  OLDIFS="$IFS"
  IFS="
"  #We set IFS to newline here so that spaces can survive the for loop
  #sed copies filename to the beginning, to compare version, and later we remove it with cut
  for foundapk in $(find $SOURCES/$2/*app/$1 -iname '*.apk' | sed 's!.*/\(.*\)!\1/&!' | sort -r -t/ -k1,1 | cut -d/ -f2-); do
    foundpath="$(dirname "$(dirname "$foundapk")")"
    api="$(basename "$foundpath")"
    if [ "$api" -le "$API" ]; then
      #We need to keep them sorted
      sourceapks="$(find "$foundpath" -name "*.apk" | sed 's!.*/\(.*\)!\1/&!' | sort -r -t/ -k1,1 | cut -d/ -f2-)"
      break
    fi
  done
  IFS="$OLDIFS"
  if [ -z "$sourceapks" ]; then
    echo "WARNING: No APK found compatible with API level $API for package $appname on $2, lowest found: $api" >&2
    return 1 #error
  fi
  #$sourceapks and $api have the useful returnvalues
  return 0 #return that it was a success
}

SOURCES="$1"
API="$2"
PACKAGE_NAME="$3"
ARCH="$4"

if getsourceforapi "$PACKAGE_NAME" "$ARCH"; then
echo "$sourceapks" | grep nodpi
else
exit 1
fi