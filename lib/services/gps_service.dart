// import 'package:flutter/material.dart';
// import 'package:geocoder/geocoder.dart' as geo;
// import 'package:geolocator/geolocator.dart';
// import 'package:injectable/injectable.dart';
// import 'package:qonstanta/models/gps.dart';

// @lazySingleton
// class GpsService {
//   Gps gps;

//   Future checkGPSEnabled() async {
//     debugPrint('checkGPSEnabled');
//     return await Geolocator.isLocationServiceEnabled();
//   }
//   // Future checkGPSEnabled() async {
//   //   debugPrint('checkGPSEnabled');
//   //   return await isLocationServiceEnabled();
//   // }

//   Future<bool> checkGPSPermission() async {
//     debugPrint('checkGPSPermission');
//     LocationPermission permissionStatus = await Geolocator.checkPermission();

//     debugPrint(permissionStatus.toString());
//     if (permissionStatus == LocationPermission.denied ||
//         permissionStatus == LocationPermission.deniedForever) {
//       return false;
//     } else {
//       return true;
//     }
//   }
//   // Future<bool> checkGPSPermission() async {
//   //   debugPrint('checkGPSPermission');
//   //   LocationPermission permissionStatus = await checkPermission();

//   //   debugPrint(permissionStatus.toString());
//   //   if (permissionStatus == LocationPermission.denied ||
//   //       permissionStatus == LocationPermission.deniedForever) {
//   //     return false;
//   //   } else {
//   //     return true;
//   //   }
//   // }

//   Future requestGPSPermission() async {
//     debugPrint('requestGPSPermission');
//     LocationPermission permissionStatus = await Geolocator.requestPermission();

//     debugPrint(permissionStatus.toString());
//   }
//   // Future requestGPSPermission() async {
//   //   debugPrint('requestGPSPermission');
//   //   LocationPermission permissionStatus = await requestPermission();

//   //   debugPrint(permissionStatus.toString());
//   // }

//   Future getGPSLocation() async {
//     debugPrint('getGPSLocation');

//     try {
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//         forceAndroidLocationManager: false,
//         timeLimit: Duration(seconds: 10),
//       );
//       // Position position = await getCurrentPosition(
//       //   desiredAccuracy: LocationAccuracy.high,
//       //   forceAndroidLocationManager: false,
//       //   timeLimit: Duration(seconds: 10),
//       // );

//       if (this.gps == null)
//         debugPrint('(lng,lat) : ${position.longitude.toString()},'
//             '${position.latitude.toString()}');
//       gps = Gps(lng: position.longitude, lat: position.latitude);
//       return this.gps == null
//           ? Gps(lng: position.longitude, lat: position.latitude)
//           : gps;
//     } catch (e) {
//       print(e);
//       debugPrint('(lng,lat) : (106.830711,-6.385589) => Default Location');
//       // gps = Gps(lng: 106.830711, lat: -6.385589);
//       return null;
//     }
//   }

//   Future getAddress(Gps gps) async {
//     // Gps gps = await getGPSLocation();
//     final lnglat = geo.Coordinates(gps.lat, gps.lng);
//     final address =
//         await geo.Geocoder.local.findAddressesFromCoordinates(lnglat);
//     return address.first;
//   }
// }
