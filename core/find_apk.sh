#!/bin/bash

getlatestapk() {
  # This functions finds the latest available version for the given architeture.
  aaptcmd="$3"
  sourceapk=""
  highversion=""
  tempapks=( )
  OLDIFS="$IFS"
  IFS="
" # We set IFS to newline here so that filenames containing spaces are
  # handled correctly in the for-loops below.

  local LZ_DECOMPRESS_CMD="false"
  if command -v lunzip > /dev/null; then
    LZ_DECOMPRESS_CMD="lunzip"
  elif command -v lzip > /dev/null; then
    LZ_DECOMPRESS_CMD="lzip --decompress"
  fi;

  # decompress apks
  # some apks are lz compressed to work around github file-size limits.
  for foundapklz in $(find "$1" -iname '*.apk.lz'); do
    $LZ_DECOMPRESS_CMD --keep "$foundapklz" || echo "Warning: lz decompress command failed for $foundapklz" >&2
  done

  # sed copies filename to the beginning, to compare version, and later we remove it with cut
  for foundapk in $(find "$1" -iname '*.apk' | sed 's!.*/\(.*\)!\1/&!' | sort -r -t/ -k1,1 -n | cut -d/ -f2-); do
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
    
    if [ -z "$highversion" ]; then
      # Take note of the highest version.
      highversion="$apkversion"
    elif [ "$highversion" != "$apkversion" ]; then
      # Skip lower versions.
      break;
    fi
    # Add package to list.
    tempapks+=("$foundapk")
  done
  
  if [ ${#tempapks[@]} -ge 2 ]; then
    # See if there is a package for this dpi or a nodpi package.
    for foundapk in ${tempapks[@]}; do
      dpipath="$(dirname "$foundapk")"
      dpi="$(basename "$dpipath")"
      if [[ "$dpi" = "nodpi" || "$dpi" = "$2" ]]; then
        sourceapk="$foundapk"
        break;
      fi
      
      if [ "$2" != "nodpi" ]; then
        # Check if the package dpi is a range and if the device falls between that range
        lodpi=$(echo "$dpi" | cut -d '-' -f 1)
        if [[ "$lodpi" != "$dpi" && "$lodpi" -le "$2" && $(echo "$dpi" | rev | cut -d '-' -f 1 | rev) -ge "$2" ]]; then
          sourceapk="$foundapk"
          break;
        fi
      fi
    done
    
    # If the device is set to nodpi, we take the highest dpi available. This should be the first one on the list.
    if [[ -z "$sourceapk" && "$2" = "nodpi" ]]; then
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
        if [ "$dpi" -ge "$2" ]; then
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
    echo "WARNING: No APK found compatible with API level $API for package $PACKAGE_NAME on $ARCH" >&2
    return 1 #error
  fi
  
  #$sourceapk has the useful return value
  return 0 #return that it was a success
}

getconformapk() {
  # This functions finds the latest available version for the given architeture and dpi. IF the chosen dpi is not available, nodpi will be selected.
  sourceapk=""
  OLDIFS="$IFS"
  IFS="
" # We set IFS to newline here so that spaces can survive the for loop
  # sed copies filename to the beginning, to compare version, and later we remove it with cut
  for foundapk in $(find "$1" -iname '*.apk' | sed 's!.*/\(.*\)!\1/&!' | sort -r -t/ -k1,1 -n | cut -d/ -f2-); do
    founddpipath="$(dirname "$foundapk")"
    dpi="$(basename "$founddpipath")"
    lodpi=$(echo "$dpi" | cut -d '-' -f 1)
    if [[ "$dpi" = "nodpi" || "$dpi" = "$2"
       || ( "$2" != "nodpi" && "$lodpi" != "$dpi" && "$lodpi" -le "$2" && $(echo "$dpi" | rev | cut -d '-' -f 1 | rev) -ge "$2" ) ]]; then
        sourceapk="$foundapk"
        break;
    fi
  done
  
  IFS="$OLDIFS"
  if [ -z "$sourceapk" ]; then
    echo "WARNING: No APK found compatible with API level $API for package $PACKAGE_NAME on $ARCH and dpi $2" >&2
    return 1 #error
  fi
  #$sourceapk has the useful return value
  return 0 #return that it was a success
}

getapk()
{
  if [ "$3" = false ]; then
    aaptcmd="$4"
    if hash "$aaptcmd" 2> /dev/null; then
      getlatestapk "$1" "$2" "$aaptcmd"
    else
      echo "ERROR: aapt not found. Unable to detect latest package." >&2
      return 1
    fi
  else
    getconformapk "$1" "$2"
  fi
  
  return $?
}

getappapidir() {
  # Check if app directory exists.
  if [ ! -d "$1/$2/"*"app/$3" ]; then
    return 1 # Package does not exist for this arch.
  fi
  
  for apidir in $(ls -vr "$1/$2/"*"app/$3"); do
    if [ "$apidir" -le "$4" ]; then
      appapidir=$(echo "$1/$2/"*"app/$3/$apidir")
      return 0
    fi
  done
  
  echo "WARNING: No APK found compatible with API level $4 for package $3 on $2" >&2
  return 1
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

if ! getappapidir "$SOURCES" "$ARCH" "$PACKAGE_NAME" "$API"; then
  exit 1
fi

if getdpivalue "$DPI"; then
  if getapk "$appapidir" "$dpivalue" "$FORCE_DPI" "$AAPT_CMD"; then
    echo "$sourceapk"
  else
    exit 1
  fi
elif getapk "$appapidir" "nodpi" "$FORCE_DPI" "$AAPT_CMD"; then
  echo "$sourceapk"
else
  exit 1
fi
