import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_route_provider/services/home_service.dart';
import 'dart:convert' as convert;

class DirectionRepo {
  late HomeService homeService;

  DirectionRepo() {
    homeService = HomeService();
  }

  Future<Map<String, dynamic>> getDirection(
    String origin,
    String destination,
  ) async {
    try {
      var response = await homeService.getDirections(origin, destination);
      var json = convert.jsonDecode(response.body);
      final polyline = json['routes'][0]['overview_polyline']['points'];
      final decodedPolyline = PolylinePoints().decodePolyline(polyline);
      return {
        'bounds_ne': json['routes'][0]['bounds']['northeast'],
        'bounds_sw': json['routes'][0]['bounds']['southwest'],
        'start_location': json['routes'][0]['legs'][0]['start_location'],
        'end_location': json['routes'][0]['legs'][0]['end_location'],
        'poly_line': polyline,
        'polylined_decoded': decodedPolyline,
      };
    } catch (e) {
      rethrow;
    }
  }
}
