import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPage extends StatefulWidget {
  final LatLng destination;
  final String? establishmentName;
  final bool hideFloatingActionButton;
  const LocationPage({
    super.key,
    required this.destination,
    this.establishmentName,
    this.hideFloatingActionButton = false,
  });

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String apiKey = 'AIzaSyCdd21sfB3sTEaDQUF5PnSdag-396fNq6Y';
  final Completer<GoogleMapController> _controller = Completer();
  StreamSubscription<Position>? _positionStream;
  Position? userLocation;
  bool _showRestaurants = false;
  bool _showFloatingActionButton = true;

  final List<Marker> _markers = <Marker>[];

  List<LatLng> polyLineCoordinates = [];

  @override
  void initState() {
    super.initState();
    _startTracking();
    getPolyPoints();
    updateLocationMarker();
    _showFloatingActionButton = !widget.hideFloatingActionButton;
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
        updateLocationMarker();
      });
    }, onError: (error) {
      print(error);
    });

    Geolocator.getCurrentPosition().then((position) {
      setState(() {
        userLocation = position;
        updateLocationMarker();
        polyLineCoordinates = [];
        getPolyPoints();
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
        // for (var point in result.points) {
        //   polyLineCoordinates.add(
        //     LatLng(point.latitude, point.longitude),
        //   );
        // }
        setState(() {
          polyLineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
        });
      }
    });
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
    if (!_showRestaurants) {
      _markers.add(
        Marker(
          markerId: MarkerId('2'),
          position: widget.destination,
          infoWindow: InfoWindow(
            title: widget.establishmentName,
          ),
        ),
      );
    }
  }

  void showRestaurantsNearMe() {
    setState(() {
      _showRestaurants = !_showRestaurants;

      if (_showRestaurants) {
        _markers.addAll([
          const Marker(
            markerId: MarkerId('3'),
            position: LatLng(14.599824160787243, 121.0125234295981),
            infoWindow: InfoWindow(
              title: 'Kiosk Stuffed Sizzling House',
            ),
          ),
          const Marker(
            markerId: MarkerId('4'),
            position: LatLng(14.599674023129621, 121.01244949899714),
            infoWindow: InfoWindow(
              title: 'Doña Teresa',
            ),
          ),
          const Marker(
            markerId: MarkerId('5'),
            position: LatLng(14.600097949555767, 121.01268425331499),
            infoWindow: InfoWindow(
              title: 'Jakeu Cafe',
            ),
          ),
          const Marker(
            markerId: MarkerId('6'),
            position: LatLng(14.600039967103752, 121.01251345185655),
            infoWindow: InfoWindow(
              title: 'The Coffee Realm',
            ),
          ),
          const Marker(
            markerId: MarkerId('7'),
            position: LatLng(14.599400196778275, 121.01193926805622),
            infoWindow: InfoWindow(
              title: 'Pizza Dragon',
            ),
          ),
          const Marker(
            markerId: MarkerId('8'),
            position: LatLng(14.597258, 121.010275),
            infoWindow: InfoWindow(
              title: 'Varda',
            ),
          ),
          const Marker(
            markerId: MarkerId('9'),
            position: LatLng(14.597982, 121.010563),
            infoWindow: InfoWindow(
              title: 'GO...GO HEALTHY FRESHLY SQUEEZED LEMON',
            ),
          ),
          const Marker(
            markerId: MarkerId('10'),
            position: LatLng(14.597872, 121.010672),
            infoWindow: InfoWindow(
              title: 'Mojacko Donuts',
            ),
          ),
          const Marker(
            markerId: MarkerId('11'),
            position: LatLng(14.597392, 121.01058),
            infoWindow: InfoWindow(
              title: 'Good Food Good Mood',
            ),
          ),
          const Marker(
            markerId: MarkerId('12'),
            position: LatLng(14.597477, 121.010646),
            infoWindow: InfoWindow(
              title: 'Sige sa Fewa ni Virgin',
            ),
          ),
        ]);
      } else {
        _markers.removeWhere((marker) => marker.markerId.value != '1');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    userLocation!.latitude, userLocation!.longitude),
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
            if (_showFloatingActionButton)
              Positioned(
                bottom: 16,
                right: 185,
                child: FloatingActionButton(
                  onPressed: showRestaurantsNearMe,
                  child: Icon(Icons.restaurant),
                ),
              )
          ],
        ),
      ),
    );
  }
}
