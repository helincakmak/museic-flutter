import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FocusNode _searchFocusNode = FocusNode();
  bool _showRecentSearches = false;

  List<Map<String, String>> recentSearches = [
    {'name': 'FKA twigs', 'type': 'Artist', 'image': 'assets/images/recently1.png'},
    {'name': 'Hozier', 'type': 'Artist', 'image': 'assets/images/recently2.png'},
    {'name': 'Grimes', 'type': 'Artist', 'image': 'assets/images/recently3.png'},
    {'name': '1 (Remastered)', 'type': 'Album', 'image': 'assets/images/recently1.png'},
    {'name': 'Led Zeppelin', 'type': 'Artist', 'image': 'assets/images/recently2.png'},
    {'name': 'Les', 'type': 'Song', 'image': 'assets/images/recently3.png'},
  ];

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      setState(() {
        _showRecentSearches = _searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xFF111111),
        body: Container(
          padding: EdgeInsets.all(2.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 2.h, bottom: 1.h),
                  child: Text(
                    'Search',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextField(
                  focusNode: _searchFocusNode,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Artists, songs, or podcasts',
                    hintStyle: TextStyle(
                      color: Color(0xFF131313),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(3.5.w),
                      child: SvgPicture.asset(
                        'assets/vectors/search.svg',
                        color: Color(0xFF131313),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                Visibility(
                  visible: _showRecentSearches,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent searches',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        height: 40.h,
                        child: ListView.builder(
                          itemCount: recentSearches.length,
                          itemBuilder: (context, index) {
                            final searchItem = recentSearches[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: AssetImage(searchItem['image']!),
                              ),
                              title: Text(
                                searchItem['name']!,
                                style: TextStyle(color: Colors.white, fontSize: 14.sp),
                              ),
                              subtitle: Text(
                                searchItem['type']!,
                                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                              ),
                              onTap: () {},
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: !_showRecentSearches,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your top genres',
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        height: 15.h,
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 2.w,
                          crossAxisSpacing: 2.w,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            _buildCategoryTile('Pop', Colors.purple, 'assets/images/editor1.png'),
                            _buildCategoryTile('Indie', Colors.green, 'assets/images/editor2.png'),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        'Popular podcast categories',
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        height: 15.h,
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 2.w,
                          crossAxisSpacing: 2.w,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            _buildCategoryTile('News & Politics', Colors.blue, 'assets/images/review1.png'),
                            _buildCategoryTile('Comedy', Colors.red, 'assets/images/review2.png'),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        'Browse all',
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 2.h),
                      Container(
                        height: 20.h,
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 2.w,
                          crossAxisSpacing: 2.w,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            _buildCategoryTile('2021 Wrapped', Colors.green, 'assets/images/recently1.png'),
                            _buildCategoryTile('Podcasts', Colors.blueGrey, 'assets/images/recently2.png'),
                            _buildCategoryTile('Made for you', Colors.lightGreen, 'assets/images/recently3.png'),
                            _buildCategoryTile('Charts', Colors.purple, 'assets/images/recently1.png'),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Container(
                        height: 15.h,
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 2.w,
                          crossAxisSpacing: 2.w,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            _buildCategoryTile('Pop', Colors.purple, 'assets/images/editor1.png'),
                            _buildCategoryTile('Indie', Colors.green, 'assets/images/editor2.png'),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),
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

  Widget _buildCategoryTile(String title, Color color, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4.w, bottom: 4.w, left: 4.w, right: 12.w),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
          Positioned(
            right: -2.h,
            bottom: 8.h,
            child: Transform.rotate(
              angle: 0.4,
              child: Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
