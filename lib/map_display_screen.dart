import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapDisplayScreen extends StatefulWidget {
  final String location;

  MapDisplayScreen({required this.location});

  @override
  _MapDisplayScreenState createState() => _MapDisplayScreenState();
}

class _MapDisplayScreenState extends State<MapDisplayScreen> {
  GoogleMapController? _mapController;
  LatLng? _locationCoords;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _getCoordinates();
  }

  Future<void> _getCoordinates() async {
    try {
      List<Location> locations = await locationFromAddress(widget.location);
      if (locations.isNotEmpty) {
        setState(() {
          _locationCoords = LatLng(locations[0].latitude, locations[0].longitude);
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Could not find location';
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (_locationCoords != null) {
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(_locationCoords!, 12),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map Display')),
      body: _locationCoords == null
          ? Center(child: _errorMessage.isNotEmpty ? Text(_errorMessage) : CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _locationCoords!,
                zoom: 12,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('selected-location'),
                  position: _locationCoords!,
                ),
              },
            ),
    );
  }
}
