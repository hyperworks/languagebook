#/usr/bin/make

NAME := LanguageBook

TESTFLIGHT_APIKEY    := 1c5bf18d22e2fb68fdd57565c4985861_MjcyMjIwMjAxMi0wMS0xMCAwNTowMjo0Ny4wNzA3MTk
TESTFLIGHT_TEAMTOKEN := b497c9485455cb6f8f99abf358bd1c2d_NDI2MzQ0MjAxNC0wOS0wMSAwNDoyMjo0MS4yNTcyNDk

WORKDIR   := build
SRC_FILES := $(wildcard $(NAME)/* $(NAME)/**/*) Podfile
WORKSPACE := $(NAME).xcworkspace
ARCHIVE   := $(WORKDIR)/$(NAME).xcarchive
IPA       := $(WORKDIR)/$(NAME).ipa

SCHEME  := $(NAME)
CONFIG  := Debug

ifneq "$(CONFIG)" "Debug"
# NOTE: You can list all signing identities on a machine with
# $ security find-identity -v -p codesigning
IPA_SIGN_ID := "iPhone Distribution: Hyperworks Inc (5FS5J26RW8)"
IPA_PROFILE := TestFlight
endif

POD     := pod --verbose
XCBUILD := xcodebuild -configuration $(CONFIG)


ifdef BUILD_NUMBER # we're inside Jenkins
define BUILD_NOTES
Jenkins build #$(BUILD_NUMBER)

id: $(BUILD_ID)
url: $(BUILD_URL)
git: $(GIT_COMMIT)
repo: $(GIT_URL)
endef

else
BUILD_NOTES := Commandline build.

endif
export BUILD_NOTES


.PHONY: clean testflight

default: $(IPA)

clean:
	$(XCBUILD) clean
	-rm -r $(ARCHIVE)
	-rm $(IPA)

testflight: $(IPA)
	curl -vv http://testflightapp.com/api/builds.json \
		-F file=@$(IPA)                                 \
		-F api_token='$(TESTFLIGHT_APIKEY)'             \
		-F team_token='$(TESTFLIGHT_TEAMTOKEN)'         \
		-F notes="$$BUILD_NOTES"

$(WORKSPACE): $(SRC_FILES)
	$(POD) install
	touch $(WORKSPACE)

$(ARCHIVE): $(WORKSPACE)
	$(XCBUILD) -workspace $(WORKSPACE) -scheme $(SCHEME) archive -archivePath $(ARCHIVE)

$(IPA): $(ARCHIVE)
	-rm $(IPA)
ifeq "$(CONFIG)" "Debug"
	$(XCBUILD) -exportArchive -archivePath $(ARCHIVE) -exportPath $(IPA)
else
	$(XCBUILD) -exportArchive -archivePath $(ARCHIVE) -exportPath $(IPA) -exportSigningIdentity $(IPA_SIGN_ID)
endif

