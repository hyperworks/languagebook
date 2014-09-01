#!/bin/bash

WORKSPACE=LanguageBook.xcworkspace
SCHEME=LanguageBook
ARCHIVE=LanguageBook.xcarchive
IPA=LanguageBook.ipa

pod install --verbose
xcodebuild -workspace $WORKSPACE -scheme $SCHEME archive -archivePath $ARCHIVE
xcodebuild -exportArchive -archivePath $ARCHIVE -exportPath $IPA

