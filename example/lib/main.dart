import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_dragmarker/dragmarker.dart';
import 'package:latlong2/latlong.dart';

void main() => runApp(const TestApp());

class TestApp extends StatefulWidget {
  const TestApp({super.key});

  @override
  TestAppState createState() => TestAppState();
}

class TestAppState extends State<TestApp> {
  late final List<DragMarker> _dragMarkers;

  @override
  void initState() {
    _dragMarkers = [
      DragMarker(
        point: LatLng(45.535, -122.675),
        offset: const Offset(0, -30),
        builder: (_, __, ___) => const Icon(
          Icons.location_on,
          size: 50,
          color: Colors.blueGrey,
        ),
        onDragStart: (details, point) => debugPrint("Start point $point"),
        onDragEnd: (details, point) => debugPrint('End point $details $point'),
      ),
      DragMarker(
        point: LatLng(45.2131, -122.6765),
        offset: const Offset(0, -30),
        builder: (_, __, isDragging) {
          if (isDragging) {
            return const Icon(Icons.edit_location, size: 75);
          }
          return const Icon(
            Icons.location_on,
            size: 50,
            color: Colors.blueGrey,
          );
        },
        onDragStart: (details, point) => debugPrint("Start point $point"),
        onDragEnd: (details, point) => debugPrint("End point $point"),
        onTap: (point) => debugPrint("on tap"),
        onLongPress: (point) => debugPrint("on long press"),
        feedbackOffset: const Offset(0.0, -75),
        updateMapNearEdge: true,
        nearEdgeRatio: 2.0,
        nearEdgeSpeed: 1.0,
      ),
      DragMarker(
        point: LatLng(45.4131, -122.9765),
        height: 50,
        width: 75,
        builder: (_, pos, ___) {
          return Card(
            color: Colors.blueGrey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  pos.latitude.toStringAsFixed(3),
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  pos.longitude.toStringAsFixed(3),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FlutterMap(
            options: MapOptions(center: LatLng(45.5231, -122.6765), zoom: 9),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              DragMarkers(markers: _dragMarkers),
              MarkerLayer(markers: [
                Marker(
                    point: LatLng(45.2131, -122.6765),
                    builder: (_) => Container(color: Colors.red),
                    width: 2,
                    height: 2),
                Marker(
                    point: LatLng(45.535, -122.675),
                    builder: (_) => Container(color: Colors.red),
                    width: 2,
                    height: 2),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
