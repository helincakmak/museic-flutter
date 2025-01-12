import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../helper/router.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recently played',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/vectors/notif.svg',
                            height: 2.5.h,
                            width: 2.5.h,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4.w),
                          SvgPicture.asset(
                            'assets/vectors/recent.svg',
                            height: 2.5.h,
                            width: 2.5.h,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4.w),
                          SvgPicture.asset(
                            'assets/vectors/settings.svg',
                            height: 2.5.h,
                            width: 2.5.h,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 20.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildRecentlyPlayedItem('Album 1', 'assets/images/recently1.png'),
                      _buildRecentlyPlayedItem('Album 2', 'assets/images/recently2.png'),
                      _buildRecentlyPlayedItem('Album 3', 'assets/images/recently3.png'),
                      _buildRecentlyPlayedItem('Album 4', 'assets/images/recently1.png'),
                      _buildRecentlyPlayedItem('Album 5', 'assets/images/recently2.png'),
                      _buildRecentlyPlayedItem('Album 6', 'assets/images/recently3.png'),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(2.w),
                  child: Text(
                    'Your 2021 in review',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                _buildGridSection(),
                Padding(
                  padding: EdgeInsets.all(2.w),
                  child: Text(
                    "Editor's picks",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 20.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildEditorsPickItem('Pick 1', 'assets/images/editor1.png'),
                      _buildEditorsPickItem('Pick 2', 'assets/images/editor2.png'),
                      _buildEditorsPickItem('Pick 3', 'assets/images/editor3.png'),
                      _buildEditorsPickItem('Pick 4', 'assets/images/editor1.png'),
                      _buildEditorsPickItem('Pick 5', 'assets/images/editor2.png'),
                      _buildEditorsPickItem('Pick 6', 'assets/images/editor3.png'),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.w, right: 2.w, left: 2.w),
                  child: Text(
                    'Your 2021 in review',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                _buildGridSection(),
                Padding(
                  padding: EdgeInsets.all(2.w),
                  child: Text(
                    "Editor's picks",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 20.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildEditorsPickItem('Pick 1', 'assets/images/editor1.png'),
                      _buildEditorsPickItem('Pick 2', 'assets/images/editor2.png'),
                      _buildEditorsPickItem('Pick 3', 'assets/images/editor3.png'),
                      _buildEditorsPickItem('Pick 4', 'assets/images/editor1.png'),
                      _buildEditorsPickItem('Pick 5', 'assets/images/editor2.png'),
                      _buildEditorsPickItem('Pick 6', 'assets/images/editor3.png'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentlyPlayedItem(String title, String imagePath) {
    return Padding(
      padding: EdgeInsets.all(2.w),
      child: Column(
        children: [
          Container(
            width: 30.w,
            height: 30.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 2.w),
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildEditorsPickItem(String title, String imagePath) {
    return Padding(
      padding: EdgeInsets.only(top: 2.w, right: 2.w, left: 2.w),
      child: Column(
        children: [
          Container(
            width: 20.w,
            height: 20.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 2.w),
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildGridSection() {
    return Padding(
      padding: EdgeInsets.all(2.w),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          _buildGridItem('assets/images/review1.png'),
          _buildGridItem('assets/images/review2.png'),
        ],
      ),
    );
  }

  Widget _buildGridItem(String imagePath) {
    return Padding(
      padding: EdgeInsets.all(2.w),
      child: Container(
        height: 20.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
