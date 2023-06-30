import 'dart:async';
import 'dart:typed_data';
import 'package:app/ui/home_ui.dart';
import 'package:app/ui/profile_ui.dart';
import 'package:app/ui/reward_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng sourceLocation = LatLng(14.599824160787243, 121.0125234295981);

class LocationPage extends StatefulWidget {
  final LatLng destination;
  const LocationPage({
    super.key,
    required this.destination,
  });

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String apiKey = 'AIzaSyCdd21sfB3sTEaDQUF5PnSdag-396fNq6Y';
  final Completer<GoogleMapController> _controller = Completer();
  StreamSubscription<Position>? _positionStream;
  Position? userLocation;

  final List<Marker> _markers = <Marker>[];

  List<LatLng> polyLineCoordinates = [];

  @override
  void initState() {
    super.initState();
    _startTracking();
    getPolyPoints();
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  void _startTracking() {
    const locationOptions =
        LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 10);

    _positionStream =
        Geolocator.getPositionStream(locationSettings: locationOptions).listen(
            (Position position) {
      setState(() {
        userLocation = position;
        checkArrival();
        updateLocationMarker();
      });
    }, onError: (error) {
      print(error);
    });

    Geolocator.getCurrentPosition().then((position) {
      setState(() {
        userLocation = position;
        checkArrival();
        updateLocationMarker();
      });
    });
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    Geolocator.getCurrentPosition().then((value) async {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        apiKey,
        PointLatLng(widget.destination.latitude, widget.destination.longitude),
        PointLatLng(value.latitude, value.longitude),
      );

      if (result.points.isNotEmpty) {
        for (var point in result.points) {
          polyLineCoordinates.add(
            LatLng(point.latitude, point.longitude),
          );
        }
        setState(() {});
      }
    });
  }

  void checkArrival() {
    if (userLocation != null) {
      final double distanceToDestination = Geolocator.distanceBetween(
        userLocation!.latitude,
        userLocation!.longitude,
        widget.destination.latitude,
        widget.destination.longitude,
      );

      if (distanceToDestination <= 10) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('You have arrived!'),
              content: const Text('You have reached your destination.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void updateLocationMarker() {
    _markers.clear();
    if (userLocation != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('1'),
          position: LatLng(userLocation!.latitude, userLocation!.longitude),
          infoWindow: const InfoWindow(
            title: 'My Position',
          ),
        ),
      );
    }
    _markers.add(
      Marker(
        markerId: const MarkerId('2'),
        position: sourceLocation,
        infoWindow: const InfoWindow(
          title: 'Kiosk Stuffed Sizzling House',
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: const MarkerId('3'),
        position: LatLng(14.599674023129621, 121.01244949899714),
        infoWindow: const InfoWindow(
          title: 'Doña Teresa',
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: const MarkerId('4'),
        position: LatLng(14.59995775278342, 121.01258723128379),
        infoWindow: const InfoWindow(
          title: 'Takoyakiks',
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: const MarkerId('5'),
        position: LatLng(14.600039967103752, 121.01251345185655),
        infoWindow: const InfoWindow(
          title: 'The Coffee Realm',
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: const MarkerId('6'),
        position: LatLng(14.599400196778275, 121.01193926805622),
        infoWindow: const InfoWindow(
          title: 'Pizza Dragon',
        ),
      ),
    );
  }

  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    if (index == 0) {
      // Home page is tapped
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(),
        ),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RewardPage(),
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: sourceLocation,
                  zoom: 14,
                ),
                polylines: {
                  Polyline(
                    polylineId: const PolylineId("route"),
                    points: polyLineCoordinates,
                    color: Colors.blue,
                    width: 5,
                  ),
                },
                markers: Set<Marker>.of(_markers),
                mapType: MapType.normal,
                myLocationEnabled: true,
                compassEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
              Positioned(
                top: 16,
                left: 16,
                child: FloatingActionButton(
                  onPressed: () {
                    if (userLocation != null) {
                      final cameraPosition = CameraPosition(
                        target: LatLng(
                            userLocation!.latitude, userLocation!.longitude),
                        zoom: 20,
                      );

                      final GoogleMapController controller =
                          _controller.future.then((controller) {
                        controller.animateCamera(
                            CameraUpdate.newCameraPosition(cameraPosition));
                      }) as GoogleMapController;
                    }
                  },
                  child: const Icon(Icons.location_on),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin_circle),
            label: 'Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border_outlined),
            label: 'Rewards',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
