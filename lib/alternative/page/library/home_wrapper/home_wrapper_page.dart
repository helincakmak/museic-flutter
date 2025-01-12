import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:museic/alternative/page/library/home_wrapper/widget/player_widget.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:sizer/sizer.dart';
import '../../../../presentation/pages/songEntity.dart';
import '../../artist_profile/artist_profile_page.dart';
import '../../home/home_page.dart';
import '../../profile/profile_page.dart';
import '../../search/search_page.dart';
import '../library_page.dart';

class HomePageWrapper extends StatefulWidget {
  @override
  HomePageWrapperState createState() => HomePageWrapperState();
}

class HomePageWrapperState extends State<HomePageWrapper> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlayerVisible = false;
  bool _isPlaying = false;
  String? _currentlyPlayingTitle;
  String? _currentlyPlayingArtist;
  String? _currentlyPlayingImagePath;

  Duration _duration = Duration();
  Duration _position = Duration();
  Color _dominantColor = Colors.black45;

  int _selectedIndex = 0;
  static late List<Widget> _pages;
  bool _isArtistProfilePage = false;
  bool _isProfilePage = false;
  late Widget _currentPage;

  int _currentSongIndex = 0; // Şu an çalınan şarkının index'i
  List<SongEntity> _currentSongList = []; // Mevcut şarkı listesi

  @override
  void initState() {
    super.initState();

    _audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        _duration = d;
      });
    });

    _audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        _position = p;
      });
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      _playNextSong();
    });

    _pages = [
      HomePage(),
      SearchPage(),
      LibraryPage(onPlayMusic: _playMusic),
    ];

    _currentPage = _pages[_selectedIndex];
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _isArtistProfilePage = false;
      _isProfilePage = false;
      _currentPage = _pages[_selectedIndex];
    });
  }

  void navigateToArtistProfile(String artistName, String artistImage, String artistGenre, List<SongEntity> songs) {
    setState(() {
      _isArtistProfilePage = true;
      _currentSongList = songs; // Şarkı listesini güncelle
      _currentSongIndex = 0; // İlk şarkıdan başla
      _currentPage = ArtistProfilePage(
        artistName: artistName,
        artistImage: artistImage,
        artistGenre: artistGenre,
        description: 'Sanatçı hakkında detaylar...',
        songs: songs,
        onPlayMusic: _playMusic,
      );
    });
  }

  void navigateToProfilePage() {
    setState(() {
      _isProfilePage = true;
      _currentPage = ProfilePage();
    });
  }

  Future<bool> _onWillPop() async {
    if (_isArtistProfilePage) {
      setState(() {
        _isArtistProfilePage = false;
        _currentPage = _pages[_selectedIndex];
      });
      return false;
    } else if (_isProfilePage) {
      setState(() {
        _isProfilePage = false;
        _currentPage = _pages[_selectedIndex];
      });
      return false;
    }
    return false;
  }

  Future<void> _playMusic(SongEntity song) async {
    try {
      await _audioPlayer.setSourceUrl(song.file);
      await _audioPlayer.resume();

      final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
        NetworkImage(song.coverImage ?? 'assets/images/default_song_image.png'),
      );
      final Color dominantColor = paletteGenerator.dominantColor?.color ?? Colors.redAccent;

      setState(() {
        _currentlyPlayingTitle = song.title;
        _currentlyPlayingArtist = song.album.artist.name;
        _currentlyPlayingImagePath = song.coverImage;
        _isPlaying = true;
        _isPlayerVisible = true;
        _dominantColor = dominantColor;
      });
    } catch (e) {
      print('Müzik çalınamadı: $e');
    }
  }

  void _playNextSong() {
    if (_currentSongList.isNotEmpty && _currentSongIndex < _currentSongList.length - 1) {
      _currentSongIndex++;
      _playMusic(_currentSongList[_currentSongIndex]);
    }
  }

  void _pauseOrResumeMusic() {
    if (_isPlaying) {
      _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
      });
    } else {
      _audioPlayer.resume();
      setState(() {
        _isPlaying = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Color(0xFF111111),
        body: Stack(
          children: [
            _currentPage,
            if (_isPlayerVisible)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: PlayerWidget(
                  audioPlayer: _audioPlayer,
                  title: _currentlyPlayingTitle,
                  artist: _currentlyPlayingArtist,
                  coverImagePath: _currentlyPlayingImagePath,
                  isPlaying: _isPlaying,
                  onPauseOrResume: _pauseOrResumeMusic,
                  duration: _duration,
                  position: _position,
                  onSeek: (value) {
                    _audioPlayer.seek(Duration(seconds: value.toInt()));
                  },
                  dominantColor: _dominantColor,
                ),
              ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/vectors/home.svg',
                height: 5.w,
                color: _selectedIndex == 0 ? Colors.white : Colors.grey,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/vectors/search.svg',
                height: 5.w,
                color: _selectedIndex == 1 ? Colors.white : Colors.grey,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/vectors/library.svg',
                height: 5.w,
                color: _selectedIndex == 2 ? Colors.white : Colors.grey,
              ),
              label: 'Your Library',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.black,
          onTap: onItemTapped,
        ),
      ),
    );
  }
}
