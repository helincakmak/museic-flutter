import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PlayerWidget extends StatelessWidget {
  final AudioPlayer audioPlayer;
  final String? title;
  final String? artist;
  final String? coverImagePath;
  final bool isPlaying;
  final Function() onPauseOrResume;
  final Duration duration;
  final Duration position;
  final Function(double) onSeek;
  final Color dominantColor; // Dominant rengi parametre olarak ekledik

  PlayerWidget({
    required this.audioPlayer,
    this.title,
    this.artist,
    this.coverImagePath,
    required this.isPlaying,
    required this.onPauseOrResume,
    required this.duration,
    required this.position,
    required this.onSeek,
    required this.dominantColor, // Dominant renk kullanımı
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: dominantColor, // Player arka plan rengi olarak dominant renk
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  coverImagePath ?? 'assets/images/default_song_image.png',
                  width: 10.w,
                  height: 10.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? 'Unknown Title',
                      style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      artist ?? 'Unknown Artist',
                      style: TextStyle(color: Colors.white54, fontSize: 10.sp),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
                onPressed: onPauseOrResume,
              ),
            ],
          ),
          // Slider kısmı
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbColor: Colors.transparent,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
            ),
            child: Slider(
              activeColor: Color(0xffB2B2B2),
              inactiveColor: Color(0xffB2B2B2).withOpacity(0.5),
              min: 0.0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: onSeek,
            ),
          ),
        ],
      ),
    );
  }
}
