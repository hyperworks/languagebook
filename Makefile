#/usr/bin/make

NAME := LanguageBook

WORKSPACE := $(NAME).xcworkspace
SCHEME    := $(NAME)
ARCHIVE   := $(NAME).xcarchive
IPA       := $(NAME).ipa

SRC_FILES := $(wildcard $(NAME)/* $(NAME)/**/*) Makefile Podfile Podfile.lock

POD     := pod --verbose
XCBUILD := xcodebuild

.PHONY: default clean

default: $(IPA)
clean:
	$(XCBUILD) clean
	rm -r $(ARCHIVE)
	rm $(IPA)

$(WORKSPACE): $(SRC_FILES)
	$(POD) install

$(ARCHIVE): $(WORKSPACE)
	$(XCBUILD) -workspace $(WORKSPACE) -scheme $(SCHEME) archive -archivePath $(ARCHIVE)

$(IPA): $(ARCHIVE)
	$(XCBUILD) -exportArchive -archivePath $(ARCHIVE) -exportPath $(IPA)

