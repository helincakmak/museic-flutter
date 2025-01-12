import 'package:flutter/material.dart';
import '../../../presentation/pages/songEntity.dart';

class LikedSongsPage extends StatefulWidget {
  final List<SongEntity> likedSongs;
  final Function(SongEntity) onRemoveFromLiked;  // Burada fonksiyon ekliyoruz

  LikedSongsPage({required this.likedSongs, required this.onRemoveFromLiked});

  @override
  _LikedSongsPageState createState() => _LikedSongsPageState();
}

class _LikedSongsPageState extends State<LikedSongsPage> {
  late List<SongEntity> likedSongs;

  @override
  void initState() {
    super.initState();
    likedSongs = widget.likedSongs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      appBar: AppBar(
        title: Text("Liked Songs"),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: likedSongs.length,
        itemBuilder: (context, index) {
          final song = likedSongs[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: song.coverImage != null
                  ? NetworkImage(song.coverImage!)
                  : null,
              child: song.coverImage == null
                  ? Text(song.title[0], style: TextStyle(fontSize: 24, color: Colors.white))
                  : null,
            ),
            title: Text(song.title, style: TextStyle(color: Colors.white)),
            subtitle: Text(song.album.artist.name, style: TextStyle(color: Colors.white54)),
            trailing: IconButton(
              icon: Icon(
                song.isLiked ? Icons.favorite : Icons.favorite_border,
                color: song.isLiked ? Colors.red : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  song.isLiked = !song.isLiked;
                  if (!song.isLiked) {
                    widget.onRemoveFromLiked(song);  // Beğeniyi kaldırırken callback'i çağırıyoruz
                  }
                });
              },
            ),
          );
        },
      ),
    );
  }
}
