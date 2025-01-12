import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class SpecialItemWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Color> gradientColors;
  final String iconPath;

  const SpecialItemWidget({
    required this.title,
    required this.subtitle,
    required this.gradientColors,
    required this.iconPath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 12.w,
        height: 12.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            width: 4.w,
            height: 4.w,
          ),
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
      subtitle: Row(
        children: [
          SvgPicture.asset(
            'assets/vectors/pin.svg',
            width: 3.w,
            height: 3.w,
            color: Colors.green,
          ),
          SizedBox(width: 2.w),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
      onTap: () {

      },
    );
  }
}
