import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:museic/core/configs/assets/app_images.dart';
import 'package:museic/core/configs/theme/app_colors.dart';
import 'package:museic/presentation/pages/splash.dart';
import 'package:museic/presentation/pages/new_songs.dart';
import 'package:museic/presentation/pages/liked_songs.dart';

import '../../../common/widgets/appbar/app_bar.dart';
import '../../../core/configs/assets/app_vectors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Set<int> _likedSongIds = {}; // Beğenilen şarkıların ID'lerini saklamak için

  void _toggleLike(int songId) {
    setState(() {
      if (_likedSongIds.contains(songId)) {
        _likedSongIds.remove(songId); // Beğeniyi kaldır
      } else {
        _likedSongIds.add(songId); // Beğeni ekle
      }
    });
  }

  bool _isLiked(int songId) {
    return _likedSongIds.contains(songId); // Şarkının beğenilip beğenilmediğini kontrol et
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        centerTitle: true,
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) => const SplashPage())
              );
            },
            icon: Icon(
              Icons.person,
              color: AppColors.primary,
              size: 28,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _homeTopCard(),
          _tabs(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                NewsSongs(
                  likedSongIds: _likedSongIds, // Set kullan
                  toggleLike: _toggleLike,
                  isLiked: _isLiked,
                ),
                LikedSongs(
                  likedSongIds: _likedSongIds, // Set kullan
                  toggleLike: _toggleLike,
                  isLiked: _isLiked,
                ),
                _artistsTabContent(),
                _podcastsTabContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _homeTopCard() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      height: 150,  // Daha yüksek bir kart
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: SizedBox(
        height: 300,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                AppVectors.homeTopCard,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 40,
                ),
                child: Image.asset(
                  AppImages.homeArtist,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabs() {
    return Material(
      color: AppColors.darkBackground,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.grey,
        indicatorColor: AppColors.primary,
        indicatorWeight: 3.0,
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        tabs: [
          Tab(
            text: 'Songs',
            icon: Icon(Icons.audiotrack),
          ),
          Tab(
            text: 'Liked Songs',
            icon: Icon(Icons.favorite),
          ),
          Tab(
            text: 'Playlist',
            icon: Icon(Icons.playlist_play),
          ),
          Tab(
            text: 'Podcasts',
            icon: Icon(Icons.podcasts),
          ),
        ],
      ),
    );
    
  }

  Widget _artistsTabContent() {
    return Center(
      child: Text('Artists Content', style: TextStyle(fontSize: 18, color: AppColors.lightBackground)),
    );
  }

  Widget _podcastsTabContent() {
    return Center(
      child: Text('Podcasts Content', style: TextStyle(fontSize: 18, color: AppColors.lightBackground)),
    );
  }
}
