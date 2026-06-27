import 'package:geolocator/geolocator.dart';

class PermissionUtils {
  static Future<bool> requestLocationPermissions() async {
    final permission = await Geolocator.requestPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  static Future<Position> getGPSLocation() async {
    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  static Future<String> getIpAddress() async => '';
}
