#!/usr/bin/env bash

set -e


SOURCE="$1"

if [[ -z "${SOURCE}" ]]; then
	ME=$(basename "$0")
	echo "Syntax: ${ME} Static.framework"
	exit 1
fi

FRAMEWORK=$(basename "${SOURCE}" .framework)
TMP=$(mktemp -d -t xcf-XXXXXXXXXX)

function StripFramework {
	local SLICE_NAME=$1
	local SLICE_ARCH=$2

	local SLICE_PATH="${TMP}/${SLICE_NAME}/${FRAMEWORK}.framework"
	mkdir -p "${SLICE_PATH}"

	cp -R "${SOURCE}" "${SLICE_PATH}"

	local OUTPUT="${SLICE_PATH}/${FRAMEWORK}.framework/${FRAMEWORK}"
	xcrun lipo -thin "${SLICE_ARCH}" "${SLICE_PATH}/${FRAMEWORK}.framework/${FRAMEWORK}" -o "${SLICE_PATH}/${FRAMEWORK}.framework/${FRAMEWORK}"
	
	echo "${SLICE_PATH}/${FRAMEWORK}.framework"
}

IPHONEOS_PATH=$(StripFramework "iphoneos" "arm64")
IPHONESIMULATOR_PATH=$(StripFramework "iphonesimulator" "x86_64")

xcodebuild -create-xcframework -framework "${IPHONEOS_PATH}" -framework "${IPHONESIMULATOR_PATH}" -output "./${FRAMEWORK}.xcframework"
