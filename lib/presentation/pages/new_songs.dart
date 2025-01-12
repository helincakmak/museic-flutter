import 'package:flutter/material.dart';
import 'package:museic/core/configs/theme/app_colors.dart';
import 'package:museic/core/api_service.dart';
import 'package:museic/presentation/pages/songPlayerPage.dart';
import 'package:museic/presentation/pages/songEntity.dart';
import 'package:museic/core/configs/assets/app_images.dart';

class NewsSongs extends StatefulWidget {
  final Set<int> likedSongIds; // Beğenilen şarkı ID'lerini almak için Set kullan
  final Function(int songId) toggleLike; // Beğenme işlevini almak için
  final bool Function(int songId) isLiked; // Şarkının beğenilip beğenilmediğini kontrol etmek için

  const NewsSongs({
    Key? key,
    required this.likedSongIds,
    required this.toggleLike,
    required this.isLiked,
  }) : super(key: key);

  @override
  _NewsSongsState createState() => _NewsSongsState();
}

class _NewsSongsState extends State<NewsSongs> {
  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return FutureBuilder<List<SongEntity>>(
      future: apiService.fetchSongs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Hata: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No songs available'));
        } else {
          List<SongEntity> songs = snapshot.data!;
          return SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemBuilder: (context, index) {
                final song = songs[index];
                final isLiked = widget.isLiked(song.id); // `widget.isLiked` kullanılarak kontrol
                return GestureDetector(
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
                  child: Container(
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          song.coverImage ?? AppImages.sarki,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.black.withOpacity(0.4),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    height: 36,
                                    width: 36,
                                    margin: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                    child: Icon(
                                      Icons.play_arrow_rounded,
                                      color: AppColors.primary,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    song.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    song.album.artist.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 6,
                          right: 6,
                          child: IconButton(
                            icon: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: isLiked ? Colors.red : Colors.white,
                              size: 24,
                            ),
                            onPressed: () => widget.toggleLike(song.id), // `widget.toggleLike` kullanılarak beğenme işlevi çağrılır
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(width: 12),
              itemCount: songs.length,
            ),
          );
        }
      },
    );
  }
}
