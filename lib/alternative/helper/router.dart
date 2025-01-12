import 'package:flutter/material.dart';
import 'package:museic/alternative/page/artist_profile/artist_profile_page.dart';
import 'package:museic/alternative/page/library/home_wrapper/home_wrapper_page.dart';
import 'package:museic/alternative/page/signup/login_page.dart'; // LoginPage'i import ettik
import '../page/home/home_page.dart';
import '../page/search/search_page.dart';
import '../page/library/library_page.dart';
import '../page/profile/profile_page.dart';
import '../page/signup/signup_page.dart';
import '../page/start/start_page.dart';
import '../../../presentation/pages/songEntity.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePageWrapper:
        return MaterialPageRoute(builder: (_) => HomePageWrapper());
      case homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case searchPage:
        return MaterialPageRoute(builder: (_) => SearchPage());
      case libraryPage:
        return MaterialPageRoute(
            builder: (_) => LibraryPage(onPlayMusic: (SongEntity song) {}));
      case profilePage:
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case startPage:
        return MaterialPageRoute(builder: (_) => StartPage());
      case signupPage:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case artistProfilePage:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ArtistProfilePage(
            artistName: args['artistName'],
            artistImage: args['artistImage'],
            artistGenre: args['artistGenre'],
            description: '',
            songs: [],
            onPlayMusic: (SongEntity) {},
          ),
        );
      case loginPage: // Yeni rota ekliyoruz
        return MaterialPageRoute(
            builder: (_) => LoginPage()); // LoginPage yönlendirmesi
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static const String homePageWrapper = '/homePageWrapper';
  static const String homePage = '/home';
  static const String searchPage = '/search';
  static const String libraryPage = '/library';
  static const String profilePage = '/profile';
  static const String startPage = '/start';
  static const String signupPage = '/signup';
  static const String artistProfilePage = '/artistProfile';
  static const String loginPage = '/login'; // Login sayfası için rota
}
