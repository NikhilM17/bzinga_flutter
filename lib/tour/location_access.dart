import 'package:bzinga/authentication/MobileNumber.dart';
import 'package:bzinga/fonts.dart';
import 'package:bzinga/utils/sharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class LocationAccess extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LocationAccessState();
  }
}

class LocationAccessState extends State<LocationAccess> {
  Geolocator _geolocator = Geolocator();

  @override
  initState() {
    super.initState();
    fetchLocation();
  }

  LocationData currentLocation;

  var location = new Location();

  void fetchLocation() async {
    try {
      currentLocation = await location.getLocation();
      _getAddressFromLatLng(
          currentLocation.latitude, currentLocation.longitude);
    } catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print("persmission denied");
      }
      currentLocation = null;
    }
  }

// Platform messages may fail, so we use a try/catch PlatformException.

  void _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> p =
          await _geolocator.placemarkFromCoordinates(latitude, longitude);

      Placemark place = p[0];

      setState(() {
        print("got address Called");
        SharedPrefs.saveLocation(place.locality, place.administrativeArea);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MobileNumber()));
      });
    } catch (e) {
      print(e);
    }
  }

  void clickedOpenSettings() {
    print("Clicked Open Settings");
  }

  @override
  Widget build(BuildContext context) {
    print("Build Called");
    return Scaffold(
      body: Container(
        color: Color(0xFF17191D),
        padding: new EdgeInsets.only(top: 48, left: 16, right: 16),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: Text(
                  'Location Permission',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: FontsManager.raleway,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: LocationImageAsset(),
              ),
              Container(
                child: Text(
                  'Location & Phone permission required.',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: FontsManager.raleway,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'To enable, go to Settings and turn on location & phone permission.',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: FontsManager.raleway,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: 200,
                padding: EdgeInsets.only(top: 24, bottom: 16),
                child: RaisedButton(
                  child: Text('Open Settings'),
                  onPressed: clickedOpenSettings,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/location.png');
    Image image = Image(image: assetImage, height: 180, width: 180);
    return Container(
        padding: EdgeInsets.only(top: 64, bottom: 64), child: image);
  }
}
