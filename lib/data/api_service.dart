import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000';


  Future<List<dynamic>> fetchSongs() async {
    final response = await http.get(Uri.parse('$baseUrl/api/songs/1'));

    if (response.statusCode == 200) {
      // Decode the response body
      final Map<String, dynamic> data = json.decode(response.body);

      // Assuming the response contains a song or list of songs
      // If the response is a single song, wrap it in a list
      return [data];
    } else {
      throw Exception('Failed to load songs');
    }
  }
}
