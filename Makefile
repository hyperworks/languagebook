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
ifdef BUILD_NUMBER
ifndef PROFILE
PROFILE := TestFlight
endif
endif

POD     := pod --verbose
XCBUILD := xcodebuild


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
ifdef PROFILE
	$(XCBUILD) -exportArchive -archivePath $(ARCHIVE) -exportPath $(IPA) -exportProvisioningProfile $(PROFILE)
else
	$(XCBUILD) -exportArchive -archivePath $(ARCHIVE) -exportPath $(IPA)
endif

