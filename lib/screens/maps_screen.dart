import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  /*
  AIzaSyCR5J14v_B_aD0VAC1spnT-Hhc7ymsPvqk
  */

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  Set<Marker> markers = {};

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(34.0151, 71.5249),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();

    markers.add(const Marker(
      markerId: MarkerId('1'),
      position: LatLng(34.0151, 71.5249),
      infoWindow: InfoWindow(
        title: 'Peshawar',
        snippet: 'My Home Town',
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Maps')),
      body: GoogleMap(
        mapType: MapType.satellite,
        markers: markers,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
