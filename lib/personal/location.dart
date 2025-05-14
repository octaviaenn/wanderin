import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Location extends StatefulWidget {
  final PageController controller;

  const Location({super.key, required this.controller});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final LatLng _center = LatLng(-7.250445, 112.768845); // Example: Surabaya
  final List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();
    _markers.add(
      Marker(
        point: _center,
        width: 40.0,
        height: 40.0,
        child: Icon(Icons.location_on, color: Colors.red),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: FlutterMap(
              options: MapOptions(
                center: _center,
                zoom: 13.0,
                onTap: (_, LatLng position) {
                  setState(() {
                    _markers.add(
                      Marker(
                        point: _center,
                        width: 40.0,
                        height: 40.0,
                        child: Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ), // Marker content
                      ),
                    );
                  });
                },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: _markers, // Use the list of markers
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 140,
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFFF3ECE4),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "Turn on location to discover events\nand activities near you.",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';

// class Location extends StatefulWidget {
//   //final VoidCallback onNext;
//   final PageController controller;

//   const Location({super.key, required this.controller});

//   @override
//   State<Location> createState() => _LocationState();
// }

// class _LocationState extends State<Location> {
//   GoogleMapController? _mapController;
//   LatLng? _currentPosition;
//   bool _loading = true;

//   @override
//   void initState() {
//     super.initState();
//     _requestLocationPermission();
//   }

//   Future<void> _requestLocationPermission() async {
//     PermissionStatus status = await Permission.location.request();

//     if (status.isGranted || status.isLimited) {
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       setState(() {
//         _currentPosition = LatLng(position.latitude, position.longitude);
//         _loading = false;
//       });
//     } else if (status.isPermanentlyDenied) {
//       openAppSettings();
//     } else {
//       setState(() {
//         _loading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _loading
//           ? const Center(child: CircularProgressIndicator())
//           : _currentPosition == null
//               ? const Center(child: Text("Location permission denied"))
//               : Stack(
//                   children: [
//                     GoogleMap(
//                       initialCameraPosition: CameraPosition(
//                         target: _currentPosition!,
//                         zoom: 15,
//                       ),
//                       markers: {
//                         Marker(
//                           markerId: const MarkerId("currentLocation"),
//                           position: _currentPosition!,
//                           infoWindow: const InfoWindow(title: "You are here"),
//                         ),
//                       },
//                       myLocationEnabled: true,
//                       onMapCreated: (controller) {
//                         _mapController = controller;
//                       },
//                     ),
//                     Positioned(
//                       top: 50,
//                       left: 20,
//                       right: 20,
//                       child: Container(
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.9),
//                           borderRadius: BorderRadius.circular(16),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 10,
//                               offset: const Offset(0, 5),
//                             ),
//                           ],
//                         ),
//                         child: const Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Allow Maps to access this device’s precise location?",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                             SizedBox(height: 8),
//                             Text("We use this to help you find nearby events."),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//     );
//   }
// }
