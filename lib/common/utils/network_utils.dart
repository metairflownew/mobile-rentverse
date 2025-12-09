import 'dart:io';

/// Convert backend URLs that contain `0.0.0.0` into an address
/// reachable from the current device/emulator.
///
/// - Android emulator (AVD): `10.0.2.2`
/// - Genymotion: `10.0.3.2` (not used by default)
/// - iOS simulator / localhost: `127.0.0.1`
String? makeDeviceAccessibleUrl(String? url) {
  if (url == null) return null;
  if (!url.contains('0.0.0.0')) return url;

  try {
    if (Platform.isAndroid) {
      return url.replaceAll('0.0.0.0', '10.0.2.2');
    }
    if (Platform.isIOS) {
      return url.replaceAll('0.0.0.0', '127.0.0.1');
    }
  } catch (_) {
    // If Platform checks fail (e.g. web) or any other error, fall back to localhost
  }

  return url.replaceAll('0.0.0.0', '127.0.0.1');
}
