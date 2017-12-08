"""
OpenGapps Copy Files

This takes the sources directory, folder and platform level as input, and produces
to the standard output a FILE:system/FILE structure that will be used by the
AOSP build system PRODUCT_COPY_FILES.
"""

import os
import re
import subprocess
import sys

def main():
    """
    Main
    """
    if len(sys.argv) != 4:
        print("expect {} [opengapps sources] [folder] [platform level]".format(sys.argv[0]))
        sys.exit(-1)

    opengapps_sources = sys.argv[1]
    if not opengapps_sources.endswith('/'):
        opengapps_sources += '/'

    folder = sys.argv[2]
    max_api_level = int(sys.argv[3])

    files = {}
    pattern = re.compile(r'(\d{2})/.*')
    for dp, dn, found_files in os.walk(opengapps_sources):
        for line in found_files:
            line = os.path.join(dp, line)
            file_name = line.strip('\n').replace(opengapps_sources, '')
            if not file_name.startswith(folder):
                continue

            # Remove folder name, we'll prepend this later
            file_name = file_name.replace('{}/'.format(folder), '')
            match = pattern.match(file_name)
            if match and int(match.group(1)) <= max_api_level:
                version = int(match.group(1))
                file_name = file_name.replace('{}/'.format(version), '')

                if file_name in files and int(files[file_name]) > version:
                    continue

                files[file_name] = version
            elif not match:
                files[file_name] = None

    for key in files:
        version = files[key]
        if version:
            print("{0}{1}/{2}/{3}:system/{1}/{3}".format(opengapps_sources, folder, version, key))
        else:
            print("{0}{1}/{2}:system/{1}/{2}".format(opengapps_sources, folder, key))

if __name__ == "__main__":
    main()
