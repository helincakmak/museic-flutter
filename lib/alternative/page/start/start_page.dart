import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:museic/alternative/page/signup/login_page.dart';  // LoginPage sayfasını import edin


import '../../helper/router.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 45.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/start_page.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Millions of Songs.\nFree on Museic.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRouter.signupPage);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 95, 165, 231),
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      shape: StadiumBorder(),
                      fixedSize: Size(80.w, 6.h),
                    ),
                    child: Text(
                      'Sign up free',
                      style: TextStyle(
                          fontSize: 17.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  _buildSocialButton(
                    label: 'Continue with Google',
                    iconPath: 'assets/vectors/google.svg',
                  ),
                  SizedBox(height: 2.h),
                  _buildSocialButton(
                    label: 'Continue with Facebook',
                    iconPath: 'assets/vectors/facebook.svg',
                  ),
                  SizedBox(height: 2.h),
                  _buildSocialButton(
                    label: 'Continue with Apple',
                    iconPath: 'assets/vectors/apple.svg',
                  ),
                  SizedBox(height: 2.h),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context,
                          AppRouter.loginPage); // Login sayfasına yönlendirme
                    },
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({required String label, required String iconPath}) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        fixedSize: Size(80.w, 6.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: Colors.white, width: 2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 5.w,
            height: 5.w,
          ),
          Spacer(),
          Text(
            label,
            style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
