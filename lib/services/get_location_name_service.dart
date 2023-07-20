import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> getLocationNameService(double latitude, double longitude) async {
  try {
    String url =
        'https://geocode.maps.co/reverse?format=json&lat=$latitude&lon=$longitude&zoom=18&addressdetails=1';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // Parsea la respuesta JSON
      final decodedData = json.decode(response.body);
      String displayName = "";
      if (decodedData['address']['suburb'] != null) {
        displayName = decodedData['address']['suburb'];
      }
      if (decodedData['address']['city'] != null) {
        displayName = decodedData['address']['city'];
      } else {
        displayName = decodedData['address']['county'];
      }

      return displayName;
      // Aquí puedes hacer algo con el nombre de la ubicación obtenido
    }
    return "";
  } catch (e) {
    // Manejo de errores
    throw Exception("error at get location");
  }
}
