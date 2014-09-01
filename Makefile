#/usr/bin/make

NAME := LanguageBook

WORKDIR   := build
SRC_FILES := $(wildcard $(NAME)/* $(NAME)/**/*) Podfile
WORKSPACE := $(NAME).xcworkspace
SCHEME    := $(NAME)
ARCHIVE   := $(WORKDIR)/$(NAME).xcarchive
IPA       := $(WORKDIR)/$(NAME).ipa

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
	touch $(WORKSPACE)

$(ARCHIVE): $(WORKSPACE)
	$(XCBUILD) -workspace $(WORKSPACE) -scheme $(SCHEME) archive -archivePath $(ARCHIVE)

$(IPA): $(ARCHIVE)
	$(XCBUILD) -exportArchive -archivePath $(ARCHIVE) -exportPath $(IPA)

