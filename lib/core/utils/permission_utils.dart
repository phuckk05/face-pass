import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  //xin quyền vị trí
  static Future<bool> requestLocationPermissions() async {
    PermissionStatus locationStatus = await Permission.location.request();
    return locationStatus.isGranted;
  }

  //lấy vị trí GPS
  static Future<Position> getGPSLocation() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  //xin quyền IP máy
  static Future<String> getIpAddress() async {
    final interfaces = await NetworkInterface.list();

    for (var interface in interfaces) {
      for (var addr in interface.addresses) {
        if (addr.type == InternetAddressType.IPv4 && !addr.isLoopback) {
          return addr.address;
        }
      }
    }

    return "";
  }
}
