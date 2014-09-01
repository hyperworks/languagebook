#/usr/bin/make

NAME := LanguageBook

WORKSPACE := $(NAME).xcworkspace
SCHEME    := $(NAME)
ARCHIVE   := $(NAME).xcarchive
IPA       := $(NAME).ipa

SRC_FILES := $(wildcard $(NAME)/* $(NAME)/**/*)

POD     := pod --verbose
XCBUILD := xcodebuild

.PHONY: deps

default: $(IPA)

$(WORKSPACE): $(SRC_FILES)
	$(POD) install

$(ARCHIVE): $(WORKSPACE)
	$(XCBUILD) -workspace $(WORKSPACE) -scheme $(SCHEME) archive -archivePath $(ARCHIVE)

$(IPA): $(ARCHIVE)
	$(XCBUILD) -exportArchive -archivePath $(ARCHIVE) -exportPath $(IPA)

