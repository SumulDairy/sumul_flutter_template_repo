#!/bin/bash

# Path to bundletool and AAB
BUNDLETOOL_JAR="tools/bundletool-all-1.18.1.jar"
AAB_PATH="build/app/outputs/bundle/prodRelease/app-prod-release.aab"

# Check existence
if [[ ! -f "$BUNDLETOOL_JAR" ]]; then
  echo "❌ Error: bundletool.jar not found at $BUNDLETOOL_JAR"
  exit 1
fi

if [[ ! -f "$AAB_PATH" ]]; then
  echo "❌ Error: AAB file not found at $AAB_PATH"
  exit 1
fi

# Run validation
echo "🔍 Validating AAB..."
java -jar "$BUNDLETOOL_JAR" validate --bundle="$AAB_PATH"

if [[ $? -eq 0 ]]; then
  echo "✅ AAB validation passed. Ready for Play Store upload."
else
  echo "❌ AAB validation failed."
fi
