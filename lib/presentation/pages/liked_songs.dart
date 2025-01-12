import 'package:flutter/material.dart';
import 'package:museic/core/api_service.dart';
import 'package:museic/presentation/pages/songEntity.dart';
import 'package:museic/presentation/pages/songPlayerPage.dart';
import 'package:museic/core/configs/theme/app_colors.dart';

class LikedSongs extends StatelessWidget {
  final Set<int> likedSongIds;
  final void Function(int songId) toggleLike;
  final bool Function(int songId) isLiked;

  const LikedSongs({
    required this.likedSongIds,
    required this.toggleLike,
    required this.isLiked,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongEntity>>(
      future: ApiService().fetchSongs(), // Şarkıları çekmek için API servisini kullanıyoruz
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Hata: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No songs available'));
        } else {
          List<SongEntity> songs = snapshot.data!;
          // Beğenilen şarkıları filtreleme
          final likedSongs = songs.where((song) => likedSongIds.contains(song.id)).toList();

          return ListView.builder(
            itemCount: likedSongs.length,
            itemBuilder: (context, index) {
              final song = likedSongs[index];
              return ListTile(
                title: Text(song.title),
                subtitle: Text(song.album.artist.name),
                trailing: IconButton(
                  icon: Icon(
                    isLiked(song.id) ? Icons.favorite : Icons.favorite_border,
                    color: isLiked(song.id) ? Colors.red : Colors.grey,
                  ),
                  onPressed: () => toggleLike(song.id),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => SongPlayerPage(
                        songEntity: song,
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
