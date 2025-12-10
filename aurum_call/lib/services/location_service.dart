// TODO: 提供定位服務，用於取得使用者當前座標。
// 依賴 geolocator 套件。
// 功能：
//  1. 檢查定位權限
//  2. 要求權限
//  3. 回傳目前 GPS 座標
//
// 未來可擴展：背景定位、志工位置回報、災情上報 GPS 標記。

import 'package:geolocator/geolocator.dart';

class LocationService {
  // 取得使用者目前的位置
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 檢查定位服務是否開啟
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("定位服務尚未開啟");
    }

    // 檢查定位權限
    permission = await Geolocator.checkPermission();

    // 若尚未允許 → 要求權限
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        throw Exception("定位權限被拒絕");
      }
    }

    // 若永遠拒絕
    if (permission == LocationPermission.deniedForever) {
      throw Exception("定位權限被永久拒絕，請至系統設定開啟。");
    }

    // 回傳目前位置
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}
