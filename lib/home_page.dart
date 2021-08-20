import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getLatAndLong();
  
  }

  GoogleMapController? gmc;
  var _kGooglePlex;
  var latitude;
  var longitude;
  Set<Marker> mymarker = {};
 

  Future<void> getLatAndLong() async {
    var location = await Geolocator.getCurrentPosition().then((value) => value);
    latitude = location.latitude;
    longitude = location.longitude;
    _kGooglePlex = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 14.4746,
    );
    mymarker = {
      Marker(
        draggable: true,
        onTap: () {
          print('Tap Marker');
        },
        markerId: MarkerId('1'),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(
          onTap: () {
            print('Tap info Marker');
          },
          title: '1',
        ),
      ),
    };
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map'),
      ),
      body: Column(
        children: [
          _kGooglePlex == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: GoogleMap(
                    onTap: (latLng) {
                      mymarker.remove(Marker(markerId: MarkerId('1')));
                      mymarker.add(
                          Marker(markerId: MarkerId('1'), position: latLng));
                      setState(() {});
                    },
                    markers: mymarker,
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      gmc = controller;
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
