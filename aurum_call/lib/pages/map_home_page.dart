// TODO: Google Maps 首頁顯示
// - 載入地圖
// - 自動定位到使用者位置
// - 支援地圖類型切換（一般、衛星）
// - 未來可擴展加入 Marker（補給站、災情）
// - 未來可加入實況監控（YouTube Live）
// - 此頁面將作為 Aurum Call 地圖系統的基礎

import 'dart:async';
import 'package:aurum_call/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();

  LatLng? _currentLatLng; // TODO: 儲存目前使用者位置
  MapType _currentMapType = MapType.normal; // TODO: 地圖類型（一般 / 衛星）

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  // TODO: 載入使用者 GPS 位置
  Future<void> _loadLocation() async {
    try {
      final position = await LocationService.getCurrentLocation();
      setState(() {
        _currentLatLng = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      debugPrint("定位失敗: $e");
    }
  }

  // TODO: 切換地圖類型
  void _toggleMapType() {
    setState(() {
      _currentMapType = (_currentMapType == MapType.normal)
          ? MapType.satellite
          : MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aurum Call 地圖"),
        actions: [
          IconButton(
            onPressed: _toggleMapType,
            icon: const Icon(Icons.layers),
            tooltip: "切換地圖類型",
          ),
        ],
      ),

      // TODO: 位置尚未取得 → 顯示 loading
      body: _currentLatLng == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              mapType: _currentMapType,
              initialCameraPosition: CameraPosition(
                target: _currentLatLng!,
                zoom: 15,
              ),
              myLocationEnabled: true,
              // 顯示藍點
              myLocationButtonEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
    );
  }
}
