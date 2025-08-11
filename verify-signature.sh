#!/bin/bash

# =============================
# Script: verify-signature.sh
# Verifies the signing of AAB and APK files using jarsigner
# =============================

AAB_PATH="build/app/outputs/bundle/prodRelease/app-prod-release.aab"
APK_PATH="build/app/outputs/flutter-apk/app-prod-release.apk"

echo "🔐 Verifying AAB Signature: $AAB_PATH"
if [ -f "$AAB_PATH" ]; then
  jarsigner -verify -verbose -certs "$AAB_PATH"
else
  echo "❌ AAB file not found at $AAB_PATH"
fi

echo ""
echo "🔐 Verifying APK Signature: $APK_PATH"
if [ -f "$APK_PATH" ]; then
  jarsigner -verify -verbose -certs "$APK_PATH"
else
  echo "❌ APK file not found at $APK_PATH"
fi
