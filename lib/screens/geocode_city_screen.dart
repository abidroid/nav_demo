import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeocodeCityScreen extends StatefulWidget {
  const GeocodeCityScreen({super.key});

  @override
  State<GeocodeCityScreen> createState() => _GeocodeCityScreenState();
}

class _GeocodeCityScreenState extends State<GeocodeCityScreen> {
  TextEditingController cityC = TextEditingController();
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  Set<Marker> markers = {};

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(34.0151, 71.5249),
    zoom: 16.4746,
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
  void dispose() {
    cityC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Geo Code City'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: TextField(
                controller: cityC,
                decoration: const InputDecoration(
                  hintText: 'City Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('Clear')),
                const Gap(16),
                ElevatedButton(
                    onPressed: () async {
                      List<Location> locations = await locationFromAddress(cityC.text.trim());

                      if (locations.isNotEmpty) {
                        Location location = locations[0];

                        cameraPosition = CameraPosition(
                          target: LatLng(location.latitude, location.longitude),
                          zoom: 16.4746,
                        );

                        markers.add(Marker(
                          markerId: MarkerId(cityC.text.trim()),
                          position: LatLng(location.longitude, location.longitude),
                          infoWindow: InfoWindow(
                            title: cityC.text.trim(),
                            //snippet: 'My Home Town',
                          ),
                        ));

                        final GoogleMapController controller = await _controller.future;
                        controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

                        //setState(() {});
                        print('Done');
                      } else {
                        print('Not Found');
                      }
                    },
                    child: const Text('Search')),
              ],
            ),
            Expanded(
              child: GoogleMap(
                mapType: MapType.hybrid,
                markers: markers,
                initialCameraPosition: cameraPosition,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            )
          ],
        ));
  }
}
