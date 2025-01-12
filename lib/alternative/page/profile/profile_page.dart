import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import '../../../core/api_service.dart';
import 'package:museic/alternative/page/library/home_wrapper/home_wrapper_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF00667B),
                  Color(0xFF002F38),
                  Color(0xFF101010),
                ],
                stops: [0.0, 0.4948, 0.8906],
              ),
            ),
            padding: EdgeInsets.only(top: 2.h, left: 2.w, right: 2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/vectors/back.svg',
                        color: Colors.white,
                        width: 6.w,
                      ),
                      onPressed: () {
                        final wrapperState = context.findAncestorStateOfType<HomePageWrapperState>();
                        if (wrapperState != null) {
                          wrapperState.onItemTapped(0);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                    ),
                    SvgPicture.asset(
                      'assets/vectors/more.svg',
                      color: Colors.white,
                      width: 6.w,
                    ),
                  ],
                ),
                // Profil fotoğrafı ve bilgiler
                FutureBuilder<UserProfile>(
                  future: ApiService().fetchUserProfile(), // API'den profil verisi çekme
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator()); // Yükleniyor göstergesi
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
                    } else if (!snapshot.hasData) {
                      return Center(child: Text('Kullanıcı bilgileri bulunamadı.'));
                    }

                    final user = snapshot.data!;

                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 40.sp,
                          backgroundImage: AssetImage('assets/images/avatar.png'),
                        ),
                        SizedBox(height: 2.h),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[800],
                            shape: StadiumBorder(),
                          ),
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildProfileStat('23', 'PLAYLISTS'),
                            _buildProfileStat('58', 'FOLLOWERS'),
                            _buildProfileStat('43', 'FOLLOWING'),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Playlists',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: ListView(
                children: [
                  _buildPlaylistItem('Shazam', '7 likes', imagePath: 'assets/images/playlist1.png'),
                  _buildPlaylistItem('Roadtrip', '4 likes', imagePath: 'assets/images/playlist2.png'),
                  _buildPlaylistItem('Study', '5 likes', imagePath: 'assets/images/playlist3.png'),
                  _buildPlaylistItem('See all playlists', '', isSeeAll: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStat(String stat, String label) {
    return Column(
      children: [
        Text(
          stat,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.grey, fontSize: 10.sp),
        ),
      ],
    );
  }

  Widget _buildPlaylistItem(String title, String subtitle, {String? imagePath, bool isSeeAll = false}) {
    return ListTile(
      leading: isSeeAll
          ? null
          : ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath!,
                width: 10.w,
                height: 10.w,
                fit: BoxFit.cover,
              ),
            ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 16.sp),
      ),
      subtitle: isSeeAll
          ? null
          : Text(
              subtitle,
              style: TextStyle(color: Colors.grey, fontSize: 14.sp),
            ),
      trailing: SvgPicture.asset(
        'assets/vectors/forward.svg',
        width: 4.w,
        color: Colors.white,
      ),
      onTap: () {
        if (isSeeAll) {
          // See all action
        }
      },
    );
  }
}
