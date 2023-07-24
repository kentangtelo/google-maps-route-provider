import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

final apiKey = FlutterConfig.get('GOOGLE_MAPS_API_KEY');

class HomeService {
  Future getDirections(
    String origin,
    String destination,
  ) async {
    print(apiKey);
    final String url = 'https://maps.googleapis.com/maps/api/direction/json?'
        'origin=$origin&destination=$destination&key=$apiKey';
    try {
      return await http.get(
        Uri.parse(url),
      );
    } catch (e) {
      rethrow;
    }
  }
}
