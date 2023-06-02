import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppGoogleMap extends StatefulWidget {
  const AppGoogleMap({super.key});

  @override
  State<AppGoogleMap> createState() => _AppGoogleMapState();
}

class _AppGoogleMapState extends State<AppGoogleMap> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomGesturesEnabled: true,
      zoomControlsEnabled: false,
      markers: <Marker>{
        Marker(
          markerId: const MarkerId('marker_1'),
          draggable: true,
          onDrag: (values) {
            //    value.ondrag(values);
          },
          position: LatLng(
            37.42796133580664,
            -122.085749655962,
          ),
          infoWindow: const InfoWindow(
              title: 'Marker Title', snippet: 'Marker Snippet'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      },
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
        Factory<OneSequenceGestureRecognizer>(
          () => EagerGestureRecognizer(),
        ),
      },
      onMapCreated: (controller) {
        // setState(() {
        //   ismapCreated = true;
        // });
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(
          37.42796133580664,
          -122.085749655962,
        ),
        zoom: 15.0,
      ),
    );
  }
}
