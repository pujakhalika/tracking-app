import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({Key? key}) : super(key: key);

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage>
    with TickerProviderStateMixin {
  late bool _navigationMode;
  late int _pointerCount;
  late TurnOnHeadingUpdate _turnOnHeadingUpdate;
  late StreamController<void> _turnHeadingUpStreamController;
  late FollowOnLocationUpdate _followOnLocationUpdate;
  late StreamController<double?> _followCurrentLocationStreamController;
  late final _animatedMapController = AnimatedMapController(vsync: this);
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _followOnLocationUpdate = FollowOnLocationUpdate.always;
    _followCurrentLocationStreamController =
        StreamController<double?>.broadcast();
    _navigationMode = false;
    _pointerCount = 0;
    _followOnLocationUpdate = FollowOnLocationUpdate.never;
    _turnOnHeadingUpdate = TurnOnHeadingUpdate.never;
    _followCurrentLocationStreamController = StreamController<double?>();
    _turnHeadingUpStreamController = StreamController<void>();
    _addressController = TextEditingController();
  }

  @override
  void dispose() {
    _followCurrentLocationStreamController.close();
    _turnHeadingUpStreamController.close();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _updateAddress(LatLng latLng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      latLng.latitude,
      latLng.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      String address = placemark.street ?? placemark.name ?? 'Unknown Address';
      _addressController.text = address;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: _addressController,
            decoration: const InputDecoration(labelText: 'Current Address'),
          ),
          Expanded(
            child: FlutterMap(
              mapController: _animatedMapController.mapController,
              options: MapOptions(
                center: const LatLng(0, 0),
                zoom: 1,
                minZoom: 0,
                maxZoom: 19,
                onPointerDown: _onPointerDown,
                onPointerUp: _onPointerUp,
                onPointerCancel: _onPointerUp,
                onPositionChanged: _onPositionChanged,
              ),
              nonRotatedChildren: [
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: FloatingActionButton(
                    onPressed: _onFollowLocationButtonPressed,
                    child: const Icon(Icons.gps_fixed),
                  ),
                ),
                Positioned(
                  left: 20,
                  bottom: 20,
                  child: FloatingActionButton(
                    onPressed: _onNavigationModeButtonPressed,
                    child: const Icon(Icons.navigation_outlined),
                  ),
                ),
              ],
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                  maxZoom: 19,
                ),
                CurrentLocationLayer(
                  followScreenPoint: const CustomPoint(0.0, 1.0),
                  followScreenPointOffset: const CustomPoint(0.0, -60.0),
                  followCurrentLocationStream:
                      _followCurrentLocationStreamController.stream,
                  turnHeadingUpLocationStream:
                      _turnHeadingUpStreamController.stream,
                  followOnLocationUpdate: _followOnLocationUpdate,
                  turnOnHeadingUpdate: _turnOnHeadingUpdate,
                  style: const LocationMarkerStyle(
                    marker: DefaultLocationMarker(
                      child: Icon(
                        Icons.navigation,
                      ),
                    ),
                    markerSize: Size(40, 40),
                    markerDirection: MarkerDirection.heading,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onPointerDown(e, l) {
    _pointerCount++;
    setState(() {
      _followOnLocationUpdate = FollowOnLocationUpdate.never;
      _turnOnHeadingUpdate = TurnOnHeadingUpdate.never;
    });
  }

  void _onPointerUp(e, l) {
    if (--_pointerCount == 0 && _navigationMode) {
      setState(() {
        _followOnLocationUpdate = FollowOnLocationUpdate.always;
        _turnOnHeadingUpdate = TurnOnHeadingUpdate.always;
      });
      _followCurrentLocationStreamController.add(18);
      _turnHeadingUpStreamController.add(null);
    }
  }

  void _onFollowLocationButtonPressed() {
    setState(() {
      _followOnLocationUpdate = FollowOnLocationUpdate.always;
    });
    _followCurrentLocationStreamController.sink.add(18);
  }

  void _onNavigationModeButtonPressed() {
    setState(() {
      _navigationMode = !_navigationMode;
      _followOnLocationUpdate = _navigationMode
          ? FollowOnLocationUpdate.always
          : FollowOnLocationUpdate.never;
      _turnOnHeadingUpdate = _navigationMode
          ? TurnOnHeadingUpdate.always
          : TurnOnHeadingUpdate.never;
    });

    if (_navigationMode) {
      // ignore: void_checks
      _turnHeadingUpStreamController.add(18);
      _turnHeadingUpStreamController.add(null);
    }
  }

  void _onPositionChanged(MapPosition position, bool hasGesture) {
    if (hasGesture && _followOnLocationUpdate != FollowOnLocationUpdate.never) {
      setState(() {
        _followOnLocationUpdate = FollowOnLocationUpdate.never;
      });
      _updateAddress(position.center!);
    }
  }
}
