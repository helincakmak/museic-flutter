import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RecentlyPlayedItemWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final String audioPath;
  final VoidCallback onPlayMusic;

  const RecentlyPlayedItemWidget({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.audioPath,
    required this.onPlayMusic,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imagePath,
          fit: BoxFit.cover,
          width: 12.w,
          height: 12.w,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 13.sp,
        ),
      ),
      onTap: onPlayMusic,
    );
  }
}
