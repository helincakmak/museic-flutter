import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../core/api_service.dart';
import '../../../presentation/pages/songEntity.dart';
import 'home_wrapper/home_wrapper_page.dart';
import 'package:museic/alternative/page/library/liked_songs_page.dart';

class LibraryPage extends StatefulWidget {
  final Function(SongEntity) onPlayMusic;

  LibraryPage({required this.onPlayMusic});

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  List<SongEntity> songs = [];
  List<ArtistEntity> artists = [];
  List<AlbumEntity> albums = [];
  List<SongEntity> likedSongs = [];

  @override
  void initState() {
    super.initState();
    _fetchItemsFromService();
  }

  Future<void> _fetchItemsFromService() async {
  try {
    var fetchedSongs = await ApiService().fetchSongs();
    var fetchedArtists = await ApiService().fetchArtists();
    var fetchedAlbums = await ApiService().fetchAlbums();

    setState(() {
      songs = fetchedSongs;  // Şarkıları doğrudan al
      artists = fetchedArtists;  // Sanatçıları doğrudan al
      albums = fetchedAlbums;  // Albümleri doğrudan al
      likedSongs = songs.where((song) => song.isLiked).toList();  // Beğenilen şarkılar
    });
  } catch (e) {
    print('Veriler alınırken hata oluştu: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 2.w, left: 2.w, top: 8.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with profile and title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              final wrapperState =
                                  context.findAncestorStateOfType<
                                      HomePageWrapperState>();
                              wrapperState?.navigateToProfilePage();
                            },
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/avatar.png'),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'Your Library',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 4.w),

                  // Liked Songs Section as a collapsible folder
                  _buildLikedSongsFolder(),

                  // Artists Section
                  _buildSectionTitle("Artists"),
                  _buildArtistList(),

                  // Albums Section
                  _buildSectionTitle("Albums"),
                  _buildAlbumList(),

                  // Songs Section
                  _buildSectionTitle("Songs"),
                  _buildSongList(),

                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.w),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Liked Songs Section as a collapsible folder
  Widget _buildLikedSongsFolder() {
    return ExpansionTile(
      title: Text(
        "Liked Songs",
        style: TextStyle(
            fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      leading: Icon(Icons.favorite, color: Colors.red),
      onExpansionChanged: (expanded) {
        if (expanded) {
          // "Liked Songs" kısmına tıklandığında, yeni sayfaya yönlendir
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LikedSongsPage(
                likedSongs: likedSongs,
                onRemoveFromLiked: (song) {
                  setState(() {
                    song.isLiked = false; // Şarkıyı beğenilerden çıkar
                    likedSongs = songs
                        .where((s) => s.isLiked)
                        .toList(); // Listeyi güncelle
                  });
                },
              ),
            ),
          );
        }
      },
      children: [
        _buildLikedSongList(),
      ],
    );
  }

  ListView _buildArtistList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: artists.length,
      itemBuilder: (context, index) {
        final artist = artists[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage:
                artist.photo != null ? NetworkImage(artist.photo!) : null,
            child: artist.photo == null
                ? Text(artist.name[0],
                    style: TextStyle(fontSize: 24, color: Colors.white))
                : null,
          ),
          title: Text(artist.name, style: TextStyle(color: Colors.white)),
          subtitle: Text(artist.genre, style: TextStyle(color: Colors.white54)),
          onTap: () {
            final artistSongs = songs
                .where((song) => song.album.artist.id == artist.id)
                .toList();
            final wrapperState =
                context.findAncestorStateOfType<HomePageWrapperState>();
            wrapperState?.navigateToArtistProfile(artist.name,
                artist.photo ?? 'default_image.png', artist.genre, artistSongs);
          },
        );
      },
    );
  }

  ListView _buildAlbumList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: albums.length,
      itemBuilder: (context, index) {
        final album = albums[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: album.coverImage != null
                ? NetworkImage(album.coverImage!)
                : null,
            child: album.coverImage == null
                ? Text(album.title[0],
                    style: TextStyle(fontSize: 24, color: Colors.white))
                : null,
          ),
          title: Text(album.title, style: TextStyle(color: Colors.white)),
          subtitle:
              Text(album.artist.name, style: TextStyle(color: Colors.white54)),
          onTap: () {},
        );
      },
    );
  }

  ListView _buildSongList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage:
                song.coverImage != null ? NetworkImage(song.coverImage!) : null,
            child: song.coverImage == null
                ? Text(song.title[0],
                    style: TextStyle(fontSize: 24, color: Colors.white))
                : null,
          ),
          title: Text(song.title, style: TextStyle(color: Colors.white)),
          subtitle: Text(song.album.artist.name,
              style: TextStyle(color: Colors.white54)),
          trailing: IconButton(
            icon: Icon(
              song.isLiked ? Icons.favorite : Icons.favorite_border,
              color: song.isLiked ? Colors.red : Colors.white,
            ),
            onPressed: () {
              setState(() {
                song.isLiked = !song.isLiked; // Beğeniyi değiştir
                likedSongs = songs
                    .where((s) => s.isLiked)
                    .toList(); // Beğenilen şarkıları güncelle
              });
            },
          ),
          onTap: () {
            widget.onPlayMusic(song);
          },
        );
      },
    );
  }

  ListView _buildLikedSongList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: likedSongs.length,
      itemBuilder: (context, index) {
        final song = likedSongs[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage:
                song.coverImage != null ? NetworkImage(song.coverImage!) : null,
            child: song.coverImage == null
                ? Text(song.title[0],
                    style: TextStyle(fontSize: 24, color: Colors.white))
                : null,
          ),
          title: Text(song.title, style: TextStyle(color: Colors.white)),
          subtitle: Text(song.album.artist.name,
              style: TextStyle(color: Colors.white54)),
          onTap: () {
            widget.onPlayMusic(song);
          },
        );
      },
    );
  }
}
