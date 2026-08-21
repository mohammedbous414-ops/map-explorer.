import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MapApp());
}

class MapApp extends StatelessWidget {
  const MapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'خريطتي التفاعلية',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
      home: const MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final LatLng _currentCenter = const LatLng(33.5731, -7.5898);

  final List<Map<String, dynamic>> _savedPlaces = [
    {
      'name': 'الدار البيضاء',
      'location': const LatLng(33.5731, -7.5898),
      'snippet': 'العاصمة الاقتصادية'
    },
    {
      'name': 'الرباط',
      'location': const LatLng(34.0209, -6.8416),
      'snippet': 'العاصمة الإدارية'
    },
    {
      'name': 'مراكش',
      'location': const LatLng(31.6295, -7.9811),
      'snippet': 'المدينة الحمراء'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مستكشف الخرائط 🗺️'),
        centerTitle: true,
        backgroundColor: Colors.teal.shade900,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentCenter,
              initialZoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.map_explorer_app',
              ),
              MarkerLayer(
                markers: _savedPlaces.map((place) {
                  return Marker(
                    point: place['location'],
                    width: 50,
                    height: 50,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.redAccent,
                      size: 40,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
