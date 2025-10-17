//
// import 'package:flutter/cupertino.dart';
//
// class GoogleMap extends StatelessWidget {
//   const GoogleMap({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GoogleMap(
//       onMapCreated: (map) => dmHomeController.mapController = map,
//       initialCameraPosition: CameraPosition(
//         target: DmHomeController.nearByLocation,
//         zoom: 10,
//       ),
//       markers: {
//         Marker(
//           markerId: MarkerId("_currentLocation"),
//           position: dmHomeController.currentPosition.value!,
//           icon: dmHomeController.currentLocationIcon ?? BitmapDescriptor.defaultMarker,
//         ),
//         Marker(
//           markerId: MarkerId("_sourceLocation"),
//           position: DmHomeController.far,
//           icon: dmHomeController.farLocationIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
//         ),
//         Marker(
//           markerId: MarkerId("_destinationLocation"),
//           position: DmHomeController.nearByLocation,
//           icon: dmHomeController.nearByLocationIcon ?? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
//         ),
//       },
//     ));
//   }
// }
