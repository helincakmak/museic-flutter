import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:museic/core/configs/theme/app_colors.dart';
import 'package:museic/presentation/pages/songEntity.dart';
import 'package:museic/core/configs/assets/app_images.dart';

class SongPlayerPage extends StatefulWidget {
  final SongEntity songEntity;

  const SongPlayerPage({Key? key, required this.songEntity}) : super(key: key);

  @override
  _SongPlayerPageState createState() => _SongPlayerPageState();
}

class _SongPlayerPageState extends State<SongPlayerPage> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  Duration _songDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });
    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _songDuration = duration;
      });
    });
  }

  void _playPauseSong() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(UrlSource(widget.songEntity.file));
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _seekTo(double value) {
    final position = Duration(seconds: value.toInt());
    _audioPlayer.seek(position);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double progress = _songDuration.inSeconds > 0
        ? _currentPosition.inSeconds / _songDuration.inSeconds
        : 0.0;

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.songEntity.title,
          style: TextStyle(color: AppColors.lightBackground),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Album cover image with shadow and gradient overlay
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    widget.songEntity.coverImage ?? AppImages.sarki,
                    height: 300,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black54, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              widget.songEntity.title,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.lightBackground,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              widget.songEntity.album.title ?? 'Unknown Album',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            // Progress Slider
            Slider(
              value: progress,
              onChanged: _isPlaying ? _seekTo : null,
              activeColor: AppColors.primary,
              inactiveColor: AppColors.grey,
              thumbColor: AppColors.primary,
              min: 0.0,
              max: 1.0,
            ),

            SizedBox(height: 8),
            Text(
              '${_formatDuration(_currentPosition)} / ${_formatDuration(_songDuration)}',
              style: TextStyle(
                color: AppColors.lightBackground,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 30),
            // Playback Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous, color: AppColors.primary),
                  onPressed: () {
                    // Implement skip previous functionality
                  },
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _playPauseSong,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                  ),
                  child: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 36,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.skip_next, color: AppColors.primary),
                  onPressed: () {
                    // Implement skip next functionality
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
