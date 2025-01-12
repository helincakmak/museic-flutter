import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:museic/presentation/pages/songEntity.dart';
import 'package:html/parser.dart' as parser;

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8000';

  // Şarkı listesini çeken servis
  Future<List<SongEntity>> fetchSongs() async {
    final response = await http.get(Uri.parse('$baseUrl/api/songs/'));

    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<SongEntity> songs =
          data.map((json) => SongEntity.fromJson(json)).toList();
      return songs;
    } else {
      throw Exception('Failed to load songs');
    }
  }

  // Sanatçı listesini çeken servis
  Future<List<ArtistEntity>> fetchArtists() async {
    final response = await http.get(Uri.parse('$baseUrl/api/artists/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<ArtistEntity> artists =
          data.map((json) => ArtistEntity.fromJson(json)).toList();
      return artists;
    } else {
      throw Exception('Failed to load artists');
    }
  }

  // Albüm listesini çeken servis
  Future<List<AlbumEntity>> fetchAlbums() async {
    final response = await http.get(Uri.parse('$baseUrl/api/albums/'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<AlbumEntity> albums =
          data.map((json) => AlbumEntity.fromJson(json)).toList();
      return albums;
    } else {
      throw Exception('Failed to load albums');
    }
  }

  // Kullanıcı profilini çeken servis
  Future<UserProfile> fetchUserProfile() async {
    final response = await http.get(Uri.parse('$baseUrl/api/profile/'));

    if (response.statusCode == 200) {
      return UserProfile.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<Map<String, dynamic>> loginUser(String username, String password) async {
  final csrfToken = await getCsrfToken(); // CSRF token'ı alın

  final response = await http.post(
    Uri.parse('$baseUrl/api/login/'),
    headers: {
      'Content-Type': 'application/json',
      'X-CSRFToken': csrfToken, // CSRF token'ı header'a ekleyin
    },
    body: json.encode({
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Giriş başarısız: ${response.statusCode}');
  }
}

}

class UserProfile {
  final String username;
  final String email;
  final String gender;

  UserProfile(
      {required this.username, required this.email, required this.gender});

  // JSON'dan UserProfile nesnesine dönüştürme
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      username: json['username'],
      email: json['email'],
      gender: json['gender'],
    );
  }
}
Future<String> getCsrfToken() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/')); // Django ana sayfasına GET isteği gönderin

  if (response.statusCode == 200) {
    // HTML yanıtını parse et
    final document = parser.parse(response.body);
    
    // CSRF token'ını al
    final csrfToken = document.querySelector('input[name="csrfmiddlewaretoken"]')?.attributes['value'];

    if (csrfToken != null) {
      return csrfToken; // Token'ı geri döndür
    } else {
      throw Exception('CSRF token bulunamadı');
    }
  } else {
    throw Exception('Sayfa yüklenemedi: ${response.statusCode}');
  }
}