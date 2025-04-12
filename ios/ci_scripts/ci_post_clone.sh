#!/bin/sh

## Install CocoaPods using Homebrew.
#brew install cocoapods
#
## Install Flutter
#brew install --cask flutter
#
#
## Update generated files
#flutter pub run build_runner build

# Build ios app
flutter build ios --no-codesign
