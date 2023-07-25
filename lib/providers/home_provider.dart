import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_route_provider/repository/direction_repo.dart';

class HomeProvider with ChangeNotifier {
  Completer<GoogleMapController> googleMapController = Completer();
  TextEditingController originController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  String get destinationText => destinationController.text;
  String get originText => originController.text;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};

  int _markerIdCounter = 1;
  int _polylineIdCounter = 1;

  int get markerIdCounter => _markerIdCounter;
  int get polylineIdCounter => _polylineIdCounter;

  set markerIdCounter(int markerIdCounter) {
    _markerIdCounter = markerIdCounter;
    notifyListeners();
  }

  set polylineIdCounter(int polylineIdCounter) {
    _polylineIdCounter = polylineIdCounter;
    notifyListeners();
  }

  set originText(String originText) {
    originController.text = originText;
    notifyListeners();
  }

  set destinationText(String destinationText) {
    destinationController.text = destinationText;
    notifyListeners();
  }

  @override
  void dispose() {
    originController.dispose();
    destinationController.dispose();
    super.dispose();
  }

  void getDirectionOriginDestination() async {
    try {
      markers = <Marker>{};
      var directions = await DirectionRepo()
          .getDirection(
            originText,
            destinationText,
          )
          .timeout(
            const Duration(
              seconds: 5,
            ),
          );
      setPolyline(directions['polylined_decoded']);
      gotoSearchPlace(
        lat: directions['start_location']['lat'],
        lng: directions['start_location']['lng'],
        destinationLat: directions['end_location']['lat'],
        destinationLong: directions['end_location']['lng'],
        boundsNe: directions['bounds_ne'],
        boundsSw: directions['bounds_sw'],
      );
      notifyListeners();
    } catch (e) {
      // ignore: avoid_print
      print('void getDirectionOriginDestination() error');
    }
  }

  void setPolyline(List<PointLatLng> latLngPoints) {
    polylines = <Polyline>{};
    final String polylineId = 'polyline_$polylineIdCounter';
    polylineIdCounter++;
    polylines.add(
      Polyline(
        polylineId: PolylineId(
          polylineId,
        ),
        width: 3,
        color: Colors.red,
        points: latLngPoints
            .map(
              (point) => LatLng(
                point.latitude,
                point.longitude,
              ),
            )
            .toList(),
      ),
    );
    notifyListeners();
  }

  void setMarker({
    required LatLng latLng,
    BitmapDescriptor? markerIcon,
  }) {
    Marker marker = Marker(
      markerId: MarkerId('marker_$markerIdCounter'),
      position: latLng,
      icon: markerIcon ?? BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(
        title: markerIdCounter.toString(),
      ),
    );
    markerIdCounter++;
    markers.add(marker);
    notifyListeners();
  }

  Future<void> gotoSearchPlace({
    required double lat,
    required double lng,
    double? destinationLat,
    double? destinationLong,
    Map<String, dynamic>? boundsNe,
    Map<String, dynamic>? boundsSw,
  }) async {
    final GoogleMapController controller = await googleMapController.future;
    markers = {};
    setMarker(
      latLng: LatLng(lat, lng),
    );
    if (null == boundsNe &&
        null == boundsSw &&
        null == destinationLat &&
        null == destinationLong) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              lat,
              lng,
            ),
            zoom: 18,
          ),
        ),
      );
    } else {
      setMarker(
        latLng: LatLng(
          destinationLat!,
          destinationLong!,
        ),
      );
      controller.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(
              boundsSw!['lat'],
              boundsSw['lng'],
            ),
            northeast: LatLng(
              boundsNe!['lat'],
              boundsNe['lng'],
            ),
          ),
          32,
        ),
      );
    }
    notifyListeners();
  }
}
