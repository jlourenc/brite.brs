# #########################################################################
#
# Makefile Usage:
# > make test
# > make remove
# > make clean
#
# Use the "NO_AUTH=1" option to deploy to roku boxes with firmware < 5.2
#	that do not have the developer username/password
# Important Notes: You must do the following to use this Makefile:
#
# 1) Make sure that you have the make and curl commands line executables
#	 in your path
# 2) Define ROKU_DEV_TARGET either below, or in an environment variable
#	 set to the IP address of your Roku box.
#	 (e.g. export ROKU_DEV_TARGET=192.168.1.1)
#
##########################################################################


# ----------------- YOU CAN EDIT THE VARIABLES BELOW -----------------

# Name your app! This will be used for the name of the zip file created.
APPNAME = Brite

# The username/password you set on your Roku box when enabling developer mode.
ROKU_DEV_USERNAME ?= rokudev
ROKU_DEV_PASSWORD ?= rokudev

# The ip address of the roku box you want to deploy a build to.
ROKU_DEV_TARGET ?= 192.168.1.1

# If your roku box has authentication active (Roku firmwares 5.2 and above),
#	set this to 0
# If you use only one box, you can set this in an environment variable
#	but this value will override it
NO_AUTH=0



# --------------------------------------------------------------------------------
# ---------------- STOP EDITING HERE. DON'T CHANGE ANYTHING BELOW!! --------------
# --------------------------------------------------------------------------------

LIBS_DIR = libs
BUILD_DIR = build
OUT_DIR = out

APP_ZIP_FILE := $(OUT_DIR)/$(APPNAME).zip
APP_TEST_RESULTS_FILE := $(OUT_DIR)/$(APPNAME).xml
APP_FILES_TO_DELETE := $(OUT_DIR)/$(APPNAME).*

APP_INCLUDES = source manifest
APP_TEST_INCLUDES = source-tests/
ZIP_EXCLUDES = --exclude=*.DS_Store* --exclude=*.git*

TEST_RUNNER_SCRIPT := $(LIBS_DIR)/roku-brstestrunner/brstestrunner.py
BRS_TEST_SCRIPT := $(LIBS_DIR)/brs-test/source/brstest.brs

test: build add-tests zip cleanup deploy runtests

build:

	@echo ""
	@echo ""
	@echo ""
	@echo "0 - I'm removing the previously built"
	@echo "    application archive if it exists and"
	@echo "    setting up all the required directories"
	@echo "    for the final build"
	@echo "--------------------------------------------------------"
	@echo ""

	@if [ -e $(APP_FILES_TO_DELETE) ]; \
	then \
		echo "There is an old build here! Deleting it."; \
		rm  $(APP_FILES_TO_DELETE); \
		echo "... done." ; \
	fi

	@echo ""

	@if [ ! -d $(OUT_DIR) ]; \
	then \
		echo "Creating missing output directory."; \
		mkdir -p $(OUT_DIR); \
		echo "... done." ; \
	fi

	@if [ ! -w $(OUT_DIR) ]; \
	then \
		echo "Making the output directory writable."; \
		chmod 755 $(OUT_DIR); \
		echo "... done." ; \
	fi

	@if [ -d $(BUILD_DIR) ]; \
	then \
		echo "There is an old build directory here! Deleting it."; \
		rm -rf $(BUILD_DIR); \
		echo "... done." ; \
	fi

	@if [ ! -d $(BUILD_DIR) ]; \
	then \
		echo "Creating a new build directory."; \
		mkdir -p $(BUILD_DIR); \
		echo "... done." ; \
	fi

	@if [ ! -w $(BUILD_DIR) ]; \
	then \
		echo "Making the build directory writable."; \
		chmod 755 $(BUILD_DIR); \
		echo "... done." ; \
	fi
	@echo "... all done!"

	@echo ""
	@echo ""
	@echo ""
	@echo "1 - Before I can fill up this archive, I need"
	@echo "    to have all the source code neatly in one place."
	@echo "    So I'm copying all of that into the build"
	@echo "    dir at $(BUILD_DIR)";
	@echo "--------------------------------------------------------"
	@echo ""

	cp -r $(APP_INCLUDES) $(BUILD_DIR)

	@echo "... done."


add-tests:

	@echo ""
	@echo ""
	@echo ""
	@echo "2 - Adding tests and test framework !"
	@echo "--------------------------------------------------------"
	@echo ""

	bower install
	cp -r $(APP_TEST_INCLUDES) $(BUILD_DIR)/source/
	cp -r $(BRS_TEST_SCRIPT) $(BUILD_DIR)/source/


zip:

	@echo ""
	@echo ""
	@echo ""
	@echo "4 - This is now done, as we're at the final step:"
	@echo "    Zip it all up in $(APP_ZIP_FILE)!"
	@echo "--------------------------------------------------------"
	@echo ""

	cd $(BUILD_DIR) && zip -q -0 -r "../$(APP_ZIP_FILE)" . -i \*.png $(ZIP_EXCLUDES);
	cd $(BUILD_DIR) && zip -q -9 -r "../$(APP_ZIP_FILE)" . -x \*.png $(ZIP_EXCLUDES);
	@echo "... done."


cleanup:

	@echo ""
	@echo ""
	@echo ""
	@echo "5 - The application archive has been created! Now I'm"
	@echo "    doing a bit of cleanup by build folder '$(BUILD_DIR)'"
	@echo "--------------------------------------------------------"
	@echo ""

	rm -rf $(BUILD_DIR)
	@echo "... done."


deploy:

	@echo ""
	@echo ""
	@echo ""
	@echo "6 - To install your application, I first need to"
	@echo "    check that you have given me a target to"
	@echo "    deploy to."
	@echo "--------------------------------------------------------"
	@echo ""

	@if [ -z "$(ROKU_DEV_TARGET)" ]; \
	then \
		echo "/!\ It seems you didn't set the ROKU_DEV_TARGET environment variable to the hostname or IP of your device, or set it in the makefile in the editable section."; \
		exit 1; \
	fi
	@echo "... done."

	@echo ""
	@echo ""
	@echo ""
	@echo "7 - Cool, I know where to install your application!"
	@echo "    Now sending it to host $(ROKU_DEV_TARGET)"
	@echo "--------------------------------------------------------"
	@echo ""

	@if [ $(NO_AUTH) = 1 ]; \
	then \
		curl -s -S -F "mysubmit=Install" -F "archive=@$(APP_ZIP_FILE)" -F "passwd=" http://$(ROKU_DEV_TARGET)/plugin_install | grep "<font color" | sed "s/<font color=\"red\">//" | sed "s[</font>[["; \
	else \
		curl --user $(ROKU_DEV_USERNAME):$(ROKU_DEV_PASSWORD) --digest -s -S -F "mysubmit=Install" -F "archive=@$(APP_ZIP_FILE)" -F "passwd=" http://$(ROKU_DEV_TARGET)/plugin_install | grep "<font color" | sed "s/<font color=\"red\">//" | sed "s[</font>[["; \
	fi
	@echo "... done."

	@echo ""
	@echo ""
	@echo ""
	@echo "8 - Hey it's all done! Your app '$(APPNAME)' should now"
	@echo "    have oppened on your Roku! Enjoy!"
	@echo "--------------------------------------------------------"
	@echo ""


runtests:

	@if [ ! -f $(TEST_RUNNER_SCRIPT) ]; then \
		echo "$(COLOR_ERROR)ERROR: $(TEST_RUNNER_SCRIPT) does not exist$(COLOR_OFF)"; \
		exit 1; \
	fi

	@if [ -e "$(APP_TEST_RESULTS_FILE)" ]; then \
		echo "  >> removing old application test results file $(APP_TEST_RESULTS_FILE)"; \
		rm $(APP_TEST_RESULTS_FILE); \
	fi

	@if [ ! -d $(TST_DIR) ]; then \
		echo "  >> creating destination directory $(TST_DIR)"; \
		mkdir -p $(TST_DIR); \
	fi

	@if [ ! -w $(TST_DIR) ]; then \
		echo "  >> setting directory permissions for $(TST_DIR)"; \
		chmod 755 $(TST_DIR); \
	fi

	curl -d "" http://$(ROKU_DEV_TARGET):8060/keypress/home
	sleep 1

	$(TEST_RUNNER_SCRIPT) -i $(ROKU_DEV_TARGET) -o $(APP_TEST_RESULTS_FILE)

remove:

	@if [[ $(NO_AUTH) = 1 ]]; \
	then \
		echo "NOAUTH IS TRUE (remove)"; \
	else \
		echo "NOAUTH IS FALSE (remove)"; \
	fi

	@echo "Removing $(APPNAME) from host $(ROKU_DEV_TARGET)"

	@if [ $(NO_AUTH) = 1 ]; \
	then \
		curl -s -S -F "mysubmit=Delete" -F "archive=" -F "passwd=" http://$(ROKU_DEV_TARGET)/plugin_install | grep "<font color" | sed "s/<font color=\"red\">//" | sed "s[</font>[["; \
	else \
		curl --user $(ROKU_DEV_USERNAME):$(ROKU_DEV_PASSWORD) --digest -s -S -F "mysubmit=Delete" -F "archive=" -F "passwd=" http://$(ROKU_DEV_TARGET)/plugin_install | grep "<font color" | sed "s/<font color=\"red\">//" | sed "s[</font>[["; \
	fi

clean:

	@echo "Cleaning output directory..."
	@if [ -d $(OUT_DIR) ]; \
	then \
		rm -rf $(OUT_DIR); \
	fi

	@echo "Cleaning build directory..."
	@if [ -d $(BUILD_DIR) ]; \
	then \
		rm -rf $(BUILD_DIR); \
	fi

	@echo "Cleaning libs directory..."
	@if [ -d $(LIBS_DIR) ]; \
	then \
		rm -rf $(LIBS_DIR); \
	fi

	@echo "All done!"
