import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:sizer/sizer.dart';
import '../../../presentation/pages/songEntity.dart';

class ArtistProfilePage extends StatefulWidget {
  final String artistName;
  final String artistImage;
  final String artistGenre;
  final String description;
  final List<SongEntity> songs;
  final Function(SongEntity) onPlayMusic;

  ArtistProfilePage({
    required this.artistName,
    required this.artistImage,
    required this.artistGenre,
    required this.description,
    required this.songs,
    required this.onPlayMusic,
  });

  @override
  _ArtistProfilePageState createState() => _ArtistProfilePageState();
}

class _ArtistProfilePageState extends State<ArtistProfilePage> {
  Color _dominantColor = Colors.black;

  @override
  void initState() {
    super.initState();
    _updateDominantColor(widget.artistImage);
  }

  Future<void> _updateDominantColor(String imageUrl) async {
    final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(imageUrl),
    );
    setState(() {
      _dominantColor = paletteGenerator.dominantColor?.color ?? Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [_dominantColor, Colors.black.withOpacity(0.7)],
                    stops: [0.7, 1.0],
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 5.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        widget.artistImage,
                        width: 45.w,
                        height: 45.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      widget.artistName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      widget.artistGenre,
                      style: TextStyle(color: Colors.grey[400], fontSize: 12.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      widget.description,
                      style: TextStyle(color: Colors.white70, fontSize: 10.sp),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF111111),
                borderRadius: BorderRadius.only(),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: SvgPicture.asset(
                                    'assets/vectors/like.svg',
                                    height: 6.w,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: SvgPicture.asset(
                                    'assets/vectors/download.svg',
                                    height: 6.w,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (widget.songs.isNotEmpty) {
                              widget.onPlayMusic(widget.songs[0]);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff1ED760),
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(4.w),
                          ),
                          child: Icon(Icons.play_arrow, size: 8.w, color: Color(0xFF111111)),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey),
                  SizedBox(height: 2.h),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.songs.length,
                      itemBuilder: (context, index) {
                        final song = widget.songs[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: song.coverImage != null ? NetworkImage(song.coverImage!) : null,
                            child: song.coverImage == null
                                ? Text(song.title[0], style: TextStyle(fontSize: 16.sp, color: Colors.white))
                                : null,
                          ),
                          title: Text(
                            song.title,
                            style: TextStyle(color: Colors.white, fontSize: 14.sp),
                          ),
                          subtitle: Text(
                            song.album.artist.name,
                            style: TextStyle(color: Colors.white54, fontSize: 10.sp),
                          ),
                          onTap: () {
                            widget.onPlayMusic(song);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
