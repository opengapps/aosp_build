import sys

def main():

    f = open("%s/SharedLibrary.mk" % sys.argv[1], 'w')
    for i in range(2,len(sys.argv)):
        f.write("include $(CLEAR_VARS)\n")
        f.write("include $(GAPPS_CLEAR_VARS)\n")
        f.write("LOCAL_MODULE := %s\n" % sys.argv[i])
        f.write("include $(BUILD_GAPPS_PREBUILT_SHARED_LIBRARY)\n\n")
    f.close()

if __name__ == "__main__":
    main()
