
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// API keu - AIzaSyB7w8JhkAHJJkhweXYfp7w_28JRYI6o8zg

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController mapController;

  LatLng? _currentPosition;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = position.latitude;
    double long = position.longitude;

    LatLng location = LatLng(lat, long);

    setState(() {
      _currentPosition = location;
      _isLoading = false;
    });
  }

  // void listenToMyLocation() {
  //   LocationSettings locationSettings = const LocationSettings(
  //     accuracy: LocationAccuracy.high,
  //     distanceFilter: 100,
  //   );
  //   StreamSubscription<Position> positionStream =
  //       Geolocator.getPositionStream(locationSettings: locationSettings)
  //           .listen((Position? position) {
  //     getLocation().lat = position!.longitude.toString();
  //     getLocation().long = position.latitude.toString();
  //   });
  // }
  //


  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Real-Time Location Tracker ')
    ,
    )
    ,
    body
    :
    _isLoading
    ? const Center(
    child: CircularProgressIndicator(),
    )
        : GoogleMap(
    myLocationEnabled: true,
    myLocationButtonEnabled: true,
    zoomControlsEnabled: true,
    zoomGesturesEnabled: true,
    onMapCreated: _onMapCreated,
    initialCameraPosition: CameraPosition(
    target: _currentPosition!,
    zoom: 15,
    ),
    markers: <Marker>{
      Marker(
          markerId: MarkerId('my-location-marker'),
          position: _currentPosition!,
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: 'Charigram'),
          draggable: false,
          // draggable: true,


          onDragStart: (LatLng latLng) {

          },
          onDragEnd: (LatLng latLng) {

          }),
      Marker(
          markerId: const MarkerId('marker-1'),
          position: const LatLng(24.109068980277137, 89.97399630377993),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: '$LatLng'),
          draggable: false,
          // draggable: true,


          onDragStart: (LatLng latLng) {

          },
          onDragEnd: (LatLng latLng) {

          }),
        },

       ),

    );
  }

}
