#!/bin/bash

getlatestapk() {
  # This functions finds the latest available version for the given architeture.
  if ! stat --printf='' "$SOURCES/$2/"*"app/$1" 2> /dev/null; then
    return 1 #appname is not there, error!?
  fi
  appname="$1"
  aaptcmd="$4"
  sourceapk=""
  highcompatversion=""
  tempapks=( )
  declare -n currapk="tempapks$i"
  OLDIFS="$IFS"
  IFS="
" # We set IFS to newline here so that spaces can survive the for loop
  # sed copies filename to the beginning, to compare version, and later we remove it with cut
  for foundapk in $(find $SOURCES/$2/*app/$1 -iname '*.apk' | sed 's!.*/\(.*\)!\1/&!' | sort -r -t/ -k1,1 | cut -d/ -f2-); do
    foundpath="$(dirname "$(dirname "$foundapk")")"
    api="$(basename "$foundpath")"
    
    if [ "$api" -le "$API" ]; then
      # Get package version name
      apkprops="$("$aaptcmd" dump badging "$foundapk" 2> /dev/null)"
      apkversion="$(echo "$apkprops" | awk -F="'" '/versionName=/ {print $4}' | sed "s/'.*//g")"
      # Get invariant version name.
      # We first remove evrything after the first space.
      apkversion="$(printf "$apkversion" | cut -d ' ' -f 1)"
      # Then, we remove everything after the fourth dot.
      apkversionparts=$(echo "$apkversion" | tr '.' '\n')
      j=0
      apkversion=""
      
      for part in ${apkversionparts[@]}; do
        if [ $j -ge 4 ]; then
        break;
        else
          if [ $j -ge 1 ]; then
            apkversion+="."
          fi
          apkversion+="$part"
          ((j++))      
        fi
      done
      
      if [ -z "$highcompatversion" ]; then
        # Take note of the highest compatible version.
        highcompatversion="$apkversion"
      elif [ "$highcompatversion" != "$apkversion" ]; then
        # Skip lower versions.
        break;
      fi
      # Add package to list.
      currapk+=("$foundapk")
    fi
  done
  
  if [ ${#tempapks[@]} -ge 2 ]; then
    # See if there is a package for this dpi or a nodpi package.
    for foundapk in ${tempapks[@]}; do
      dpipath="$(dirname "$foundapk")"
      dpi="$(basename "$dpipath")"
      if [[ "$dpi" = "nodpi" || "$dpi" = "$3" ]]; then
        sourceapk="$foundapk"
        break;
      fi
      
      if [ "$3" != "nodpi" ]; then
        # Check if the package dpi is a range and if the device falls between that range
        lodpi=$(echo "$dpi" | cut -d '-' -f 1)
        if [[ "$lodpi" != "$dpi" && "$lodpi" -le "$3" && $(echo "$dpi" | rev | cut -d '-' -f 1 | rev) -ge "$3" ]]; then
          sourceapk="$foundapk"
          break;
        fi
      fi
    done
    
    # If the device is set to nodpi, we take the highest dpi available. This should be the first one on the list.
    if [[ -z "$sourceapk" && "$3" = "nodpi" ]]; then
      sourceapk="$tempapks"
    fi
    
    # Take the lowest dpi above the device dpi or the highest dpi under the device dpi.
    if [ -z "$sourceapk" ]; then
      for foundapk in ${tempapks[@]}; do
        dpipath="$(dirname "$foundapk")"
        dpi="$(basename "$dpipath")"
        # If this is a range, we already know the device is either over or under that range.
        # Therefore, we can safely take any value.
        dpi=$(echo "$dpi" | cut -d '-' -f 1)
        if [ "$dpi" -ge "$3" ]; then
          sourceapk="$foundapk"
        else
          # If we havn't found a higher dpi, we take the first (highest) lower dpi.
          if [ -z "$sourceapk" ]; then
            sourceapk="$foundapk"
          fi
          break;
        fi
      done
    fi
  elif [ ${#tempapks[@]} -ge 1 ]; then
    # If theres only one apk, take that one.
    sourceapk="$tempapks"
  fi
  
  IFS="$OLDIFS"
  if [ -z "$sourceapk" ]; then
    echo "WARNING: No APK found compatible with API level $API for package $appname on $2" >&2
    return 1 #error
  fi
  
  api="$(basename "$(dirname "$(dirname "$sourceapk")")")"
  
  #$sourceapk and $api have the useful returnvalues
  return 0 #return that it was a success
}

getconformapk() {
  # This functions finds the latest available version for the given architeture and dpi. IF the chosen dpi is not available, nodpi will be selected.
  if ! stat --printf='' "$SOURCES/$2/"*"app/$1" 2> /dev/null; then
    return 1 #appname is not there, error!?
  fi
  appname="$1"
  sourceapk=""
  OLDIFS="$IFS"
  IFS="
" # We set IFS to newline here so that spaces can survive the for loop
  # sed copies filename to the beginning, to compare version, and later we remove it with cut
  for foundapk in $(find $SOURCES/$2/*app/$1 -iname '*.apk' | sed 's!.*/\(.*\)!\1/&!' | sort -r -t/ -k1,1 | cut -d/ -f2-); do
    founddpipath="$(dirname "$foundapk")"
    dpi="$(basename "$founddpipath")"
    lodpi=$(echo "$dpi" | cut -d '-' -f 1)
    if [[ "$dpi" = "nodpi" || "$dpi" = "$3"
       || ( "$3" != "nodpi" && "$lodpi" != "$dpi" && "$lodpi" -le "$3" && $(echo "$dpi" | rev | cut -d '-' -f 1 | rev) -ge "$3" ) ]]; then
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
    echo "WARNING: No APK found compatible with API level $API for package $appname on $2 and dpi $3" >&2
    return 1 #error
  fi
  #$sourceapk and $api have the useful returnvalues
  return 0 #return that it was a success
}

getapk()
{
  if [ "$4" = false ]; then
    aaptcmd="$5"
    if hash "$aaptcmd" 2> /dev/null; then
      getlatestapk "$1" "$2" "$3" "$aaptcmd"
    else
      echo "ERROR: aapt not found. Unable to detect latest package." >&2
      return 1
    fi
  else
    getconformapk "$1" "$2" "$3"
  fi
  
  return $?
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
FORCE_DPI="$6"
AAPT_CMD="$7"

if getdpivalue "$DPI"; then
  if getapk "$PACKAGE_NAME" "$ARCH" "$dpivalue" "$FORCE_DPI" "$AAPT_CMD"; then
    echo "$sourceapk"
  else
    exit 1
  fi
elif getapk "$PACKAGE_NAME" "$ARCH" "nodpi" "$FORCE_DPI" "$AAPT_CMD"; then
  echo "$sourceapk"
else
  exit 1
fi