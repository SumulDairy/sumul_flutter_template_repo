import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class DeviceIdHelper {
  static const _storageKey = 'persistent_device_id';

  static final _secureStorage = FlutterSecureStorage(
    iOptions: IOSOptions(
      accessibility:
          KeychainAccessibility.first_unlock, // Ensures persistence on iOS
    ),
  );

  /// Returns a persistent device ID that survives app uninstall (on iOS).
  static Future<String> getDeviceId() async {
    String? deviceId = await _secureStorage.read(key: _storageKey);

    if (deviceId == null) {
      deviceId = const Uuid().v4(); // Generate new UUID
      await _secureStorage.write(key: _storageKey, value: deviceId);
    }

    return deviceId;
  }
}
