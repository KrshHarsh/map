import 'package:flutter/material.dart';
import 'package:map/map_display_screen.dart';

class LocationInputScreen extends StatefulWidget {
  @override
  _LocationInputScreenState createState() => _LocationInputScreenState();
}

class _LocationInputScreenState extends State<LocationInputScreen> {
  final TextEditingController _locationController = TextEditingController();
  String? _errorMessage;

  void _navigateToMapScreen() {
    if (_locationController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a location.';
      });
    } else {
      setState(() {
        _errorMessage = null;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapDisplayScreen(location: _locationController.text),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Location')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                hintText: 'Enter a city, address, or coordinates',
                errorText: _errorMessage,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToMapScreen,
              child: Text('Show on Map'),
            ),
          ],
        ),
      ),
    );
  }
}
