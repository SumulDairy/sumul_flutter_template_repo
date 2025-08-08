<!-- # 🧭 sumul_transport

A modern, scalable Flutter app built for **Sumul**'s internal agents. Designed for high performance, responsive UI, and real-world usage — using GetX architecture, localization, secure API integration, and full environment support.

---

## 📱 Overview

**sumul_transport** is a full-featured mobile app for agent-based operations such as login, vehicle attendance, file handling, time-syncing, and data reporting. It includes responsive design, offline storage, secure API headers, localization, and elegant UI animations.

---

## 🚀 Features

- ✅ Clean MVC + GetX architecture
- 🌐 Multi-language localization
- 🔐 OTP & secured authentication
- 🔄 NTP-based time synchronization
- 🧠 Offline caching with SharedPreferences
- 📡 API integration via environment-based headers
- 🧾 File sharing & multipart upload
- 📷 Image picker with compression
- 💾 File handling (Open, Download)
- 📶 Connectivity detection
- 🧮 Matrix grid data input
- 📊 Staggered Grid UI
- 🎨 Smooth animations with Flutter Animate
- 📦 .env-based configuration (dev/prod)
- 🛡️ Obfuscation + API key protection

---

## 📂 Project Structure

```
lib/
├── main.dart                # Entry point, loads env via --dart-define
├── appconfig/              # AppConfig class reads from .env
├── l10n/                    # Localization .arb files
├── presentation/            # All UI modules (screens)
│   └── <feature>/           # Example: visit, vehicle, login
│       ├── ui/              # UI Screens
│       ├── widget/          # Reusable Widgets
│       ├── model/           # Feature-specific models
│       └── provider/        # Feature repositories/services
├── controller/              # GetX Controllers
├── models/                  # Global models (JSON-based)
├── services/                # API service, local storage, permissions
├── utils/                   # Constants, enums, sizing, extensions
├── resources/               # Fonts, colors, strings, images
├── routes/                  # GetX route paths
└── global/                  # Shared services & utilities
```

---

## 📦 .env Support (Single main.dart)

Supports:
- `.env.dev`
- `.env.prod`

Example `.env.prod`:

```
APP_NAME=Sumul Agent
BASE_URL=https://api.sumul.com/
USERNAME=sumul
PASSWORD=Fabjys-vyfhiw-6nuwko
```

Loaded with:

```dart
await dotenv.load(fileName: const String.fromEnvironment('ENV', defaultValue: '.env'));
```

---

## 🧾 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  get: ^4.7.2
  http: ^1.4.0
  shared_preferences: ^2.5.3
  logger: ^2.5.0
  velocity_x: ^4.3.1
  flutter_screenutil: ^5.9.3
  intl: ^0.20.2
  cached_network_image: ^3.4.1
  permission_handler: ^12.0.0+1
  gap: ^3.0.1
  pin_code_fields: ^8.0.1
  searchfield: ^1.3.2
  connectivity_plus: ^6.1.4
  image_picker: ^1.1.2
  path_provider: ^2.1.5
  flutter_spinkit: ^5.2.1
  flutter_image_compress: ^2.4.0
  flutter_localization: ^0.3.2
  flutter_staggered_grid_view: ^0.7.0
  marquee: ^2.3.0
  open_filex: ^4.7.0
  url_launcher: ^6.3.1
  ntp: ^2.0.0
  flutter_staggered_animations: ^1.1.1
  flutter_animate: ^4.5.2
  flutter_dotenv: ^5.2.1
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

---

## 🧠 Run / Build / Test Commands

### Install dependencies

```bash
flutter pub get
```

### Run (Dev / Prod mode)

```bash
flutter run --dart-define=ENV=.env.dev
flutter run --dart-define=ENV=.env.prod
```

### Build Android APK
  ```bash
    flutter build apk --flavor prod -t lib/main.dart \
    --release \
    --dart-define=ENV=.env.prod \
    --obfuscate \
    --split-debug-info=build/debug-info

    apksigner verify --verbose build/app/outputs/flutter-apk/app-prod-release.apk

  ```

  ### Build Android aab
  ```bash
    flutter build appbundle --flavor prod -t lib/main.dart \
    --release \
    --dart-define=ENV=.env.prod \
    --obfuscate \
    --split-debug-info=build/aab-debug-info

    jarsigner -verify -verbose -certs build/app/outputs/bundle/prodRelease/app-prod-release.aab

  ```

### Build iOS App

```bash
    flutter build appbundle --flavor prod -t lib/main.dart \
    --release \
    --dart-define=ENV=.env.prod \
    --obfuscate \
    --split-debug-info=build/aab-debug-info
# flutter build ios --release \
#   --dart-define=ENV=.env.prod \
#   --obfuscate \
#   --split-debug-info=build/ios-debug-info
```

### Clean & Rebuild

```bash
flutter clean
flutter pub get
```

### Localization

```bash
flutter gen-l10n
```

### Run Tests

```bash
flutter test
```

---

## 🛠 Permissions

### Android

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
```

### iOS

```xml
<key>NSCameraUsageDescription</key>
<string>Camera access is required</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Photo library access is required</string>
```

---

## 🔐 Security Best Practices

- ✅ API credentials are stored in `.env` (never hardcoded)
- ✅ Use `--obfuscate` and `--split-debug-info`
- ✅ Ensure `.env.*` is in `.gitignore`
- ✅ Use Basic Auth only in headers
- ✅ Validate `.env` values on app start

---

## 📝 Logging & Crash Reporting

- ✅ `Logger` package for app-wide logging

---

## 🧑‍💻 Maintained By

**Sumul IT Team**  
📧 admin@sumul.coop

---

## 📄 License

This app is **Proprietary** and confidential.  
All rights reserved to **Sumul Dairy**.  
Unauthorized distribution, modification, or reuse is strictly prohibited. -->


# 🛍️ sumul_transport

A modern, scalable Flutter app built for **Sumul**'s internal agents. Designed for high performance, responsive UI, and real-world usage — using GetX architecture, localization, secure API integration, and full environment support.

---

## 📱 Overview

**sumul_transport** is a full-featured mobile app for agent-based operations such as login, vehicle attendance, file handling, time-syncing, and data reporting. It includes responsive design, offline storage, secure API headers, localization, and elegant UI animations.

---

## 🚀 Features

* ✅ Clean MVC + GetX architecture
* 🌐 Multi-language localization
* 🔐 OTP & secured authentication
* 🔄 NTP-based time synchronization
* 🧠 Offline caching with SharedPreferences
* 📡 API integration via environment-based headers
* 🗞 File sharing & multipart upload
* 📷 Image picker with compression
* 💾 File handling (Open, Download)
* 📦 Connectivity detection
* 🧮 Matrix grid data input
* 📊 Staggered Grid UI
* 🎨 Smooth animations with Flutter Animate
* 📦 .env-based configuration (dev/prod)
* 🛡️ Obfuscation + API key protection
* 📲 Local notification support (platform-aware)
- 🧪 Verified production builds (APK/AAB signing + obfuscation)


---

## 📂 Project Structure

```
lib/
├── main.dart                # Entry point, loads env via --dart-define
├── appconfig/              # AppConfig class reads from .env
├── l10n/                    # Localization .arb files
├── presentation/            # All UI modules (screens)
│   └── <feature>/           # Example: visit, vehicle, login
│       ├── ui/              # UI Screens
│       ├── widget/          # Reusable Widgets
│       ├── model/           # Feature-specific models
│       └── provider/        # Feature repositories/services
├── controller/              # GetX Controllers
├── models/                  # Global models (JSON-based)
├── services/                # API service, local storage, permissions
├── utils/                   # Constants, enums, sizing, extensions
├── resources/               # Fonts, colors, strings, images
├── routes/                  # GetX route paths
└── global/                  # Shared services & utilities
```

---

## 📦 .env Support (Single main.dart)

Supports:

* `.env.dev`
* `.env.prod`

Example `.env.prod`:

```
APP_NAME=Sumul Agent
BASE_URL=https://api.sumul.com/
USERNAME=sumul
PASSWORD=Fabjys-vyfhiw-6nuwko
```

Loaded with:

```dart
await dotenv.load(fileName: const String.fromEnvironment('ENV', defaultValue: '.env'));
```

---

## 🧠 Run / Build / Test Commands

### Install dependencies

```bash
flutter pub get
```

### Run (Dev / Prod mode)

```bash
flutter run --dart-define=ENV=.env.dev
flutter run --dart-define=ENV=.env.prod
```

### Build Android APK

```bash
flutter build apk --flavor prod -t lib/main.dart \
  --release \
  --dart-define=ENV=.env.prod \
  --obfuscate \
  --split-debug-info=build/debug-info

apksigner verify --verbose build/app/outputs/flutter-apk/app-prod-release.apk
```

### Build Android aab

```bash
flutter build appbundle --flavor prod -t lib/main.dart \
  --release \
  --dart-define=ENV=.env.prod \
  --obfuscate \
  --split-debug-info=build/aab-debug-info

jarsigner -verify -verbose -certs build/app/outputs/bundle/prodRelease/app-prod-release.aab
```

### Build iOS App

```bash
flutter build appbundle --flavor prod -t lib/main.dart \
  --release \
  --dart-define=ENV=.env.prod \
  --obfuscate \
  --split-debug-info=build/aab-debug-info
# flutter build ios --release \
#   --dart-define=ENV=.env.prod \
#   --obfuscate \
#   --split-debug-info=build/ios-debug-info
```

### Clean & Rebuild

```bash
flutter clean
flutter pub get
```

### Localization

```bash
flutter gen-l10n
```

### Run Tests

```bash
flutter test
```

---

## 🛠 Permissions
**Required for full functionality:**

| Platform | Permission              | Purpose                          |
|----------|--------------------------|----------------------------------|
| Android  | `INTERNET`               | API communication                |
| Android  | `CAMERA`                 | Photo capture                    |
| Android  | `NOTIFICATIONS`          | Local notifications              |
| Android  | `WRITE_EXTERNAL_STORAGE` | File export and sharing          |
| iOS      | Notification permission  | Prompted via `flutter_local_notifications` |

> ⚠️ For Android 13+ use `POST_NOTIFICATIONS` in `AndroidManifest.xml`

### Android

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
```

### iOS

```xml
<key>NSCameraUsageDescription</key>
<string>Camera access is required</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Photo library access is required</string>
```

---

## 🔐 Security Best Practices

* ✅ API credentials are stored in `.env` (never hardcoded)
* ✅ Use `--obfuscate` and `--split-debug-info`
* ✅ Ensure `.env.*` is in `.gitignore`
* ✅ Use Basic Auth only in headers
* ✅ Validate `.env` values on app start

---

## 📝 Keystore & Signature Verification

### Keystore Configuration

Ensure your `key.properties` contains:

```properties
storePassword=********
keyPassword=********
keyAlias=upload
storeFile=app/sumulkeystore.jks
```

And your `build.gradle.kts` includes:

```kotlin
val storeFilePath = keystoreProperties["storeFile"]?.toString()
if (storeFilePath == null) throw GradleException("storeFile is null — check key.properties")

storeFile = file(storeFilePath)
storePassword = keystoreProperties["storePassword"]?.toString()
keyAlias = keystoreProperties["keyAlias"]?.toString()
keyPassword = keystoreProperties["keyPassword"]?.toString()
```

### Validate AAB & APK with bundletool

Place `bundletool.jar` in the root `/tools` folder:

```
project-root/
├── tools/
│   └── bundletool.jar
```

Then create a script named `validate-aab.sh`:

```bash
#!/bin/bash

AAB_PATH="build/app/outputs/bundle/prodRelease/app-prod-release.aab"
APK_PATH="build/app/outputs/flutter-apk/app-prod-release.apk"
BUNDLETOOL_JAR="tools/bundletool.jar"

if [ ! -f "$BUNDLETOOL_JAR" ]; then
  echo "❌ Error: bundletool.jar not found at $BUNDLETOOL_JAR"
  exit 1
fi

echo "🔍 Validating AAB signature..."
jarsigner -verify -verbose -certs "$AAB_PATH"

echo ""
echo "🔍 Validating APK signature..."
jarsigner -verify -verbose -certs "$APK_PATH"

echo ""
echo "🧪 Validating AAB structure using bundletool..."
java -jar "$BUNDLETOOL_JAR" validate --bundle="$AAB_PATH"
```

Make it executable:

```bash
chmod +x validate-aab.sh
./validate-aab.sh
```

> ℹ️ You **do not** need to include `bundletool.jar` in your app. It's for local verification only, and won’t affect your APK/AAB size.

---

## 📈 Logging & Crash Reporting

* ✅ `Logger` package for app-wide logging

---

## 🧑‍💻 Maintained By

**Sumul IT Team**
📧 [admin@sumul.coop](mailto:admin@sumul.coop)

---

## 📄 License

This app is **Proprietary** and confidential.
All rights reserved to **Sumul Dairy**.
Unauthorized distribution, modification, or reuse is strictly prohibited.
