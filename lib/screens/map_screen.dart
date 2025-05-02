// map_screen.dart
// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late googlemapcontroller ;
  final LatLng _initialPosition = const LatLng(48.8584, 2.2945); // Eiffel Tower

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('eiffel'),
      position: LatLng(48.8584, 2.2945),
      infoWindow: InfoWindow(title: 'Eiffel Tower'),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nearby Attractions')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _initialPosition, zoom: 12),
        markers: _markers,
        onMapCreated: (controller, GoogleMapController mapController) => mapController = controller,
      ),
    );
  }
}
