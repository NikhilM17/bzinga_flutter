import 'package:bzinga/auctions/auctions_list.dart';
import 'package:bzinga/authentication/MobileNumber.dart';
import 'package:bzinga/menus/terms_and_conditions.dart';
import 'package:bzinga/colors.dart';
import 'package:bzinga/fonts.dart';
import 'package:bzinga/utils/sharedPrefs.dart';
import 'package:bzinga/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';
import 'package:location/location.dart';

class LocationAccess extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LocationAccessState();
  }
}

class LocationAccessState extends State<LocationAccess> {
  bool isLoading = false;

  @override
  initState() {
    super.initState();
    isLoading = true;
    fetchLocation();
  }

  LocationData currentLocation;

  var location = new Location();

  void fetchLocation() async {
    try {
      String token = await SharedPrefs().getToken();
      bool isLoggedIn = token != null && token.isNotEmpty;

      if (!isLoggedIn) {
//      if (isLoggedIn) {
        currentLocation = await location.getLocation();
        _getAddressFromLatLng(
            currentLocation.latitude, currentLocation.longitude);
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Auctions()));
      }
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
      final coordinates = new Coordinates(latitude, longitude);
      var addresses =
          await Geocoder.google("AIzaSyB8eaE6jItlQs_HvdWA5a6Sn80cVgT-VuQ")
              .findAddressesFromCoordinates(coordinates);
      print(addresses);
      isLoading = false;

      /*List<Placemark> p =
          await _geolocator.placemarkFromCoordinates(latitude, longitude);

      Placemark place = p[0];*/

      setState(() {
        if (addresses != null && addresses.isNotEmpty) {
          print("got address Called");
          Address address = addresses.elementAt(0);
          if (address != null) {
            SharedPrefs.saveLocation(address.locality, address.adminArea);
            if (!isLoading) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MobileNumber()));
            }
          }
        } else
          print("Address is null");
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
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.only(top: 48, left: 24, right: 24),
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
                      padding: EdgeInsets.only(top: 16, right: 8, left: 8),
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
            Align(
              alignment: Alignment.center,
              child: Container(
                  color: isLoading ? CustomColor.loader_screen : null),
            ),
            Align(
              alignment: Alignment.center,
              child: Visibility(
                visible: isLoading,
                child: CircularProgressBar(),
              ),
            ),
          ],
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
