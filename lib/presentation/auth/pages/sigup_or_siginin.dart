import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:museic/common/widgets/button/basic_app_button.dart';
import 'package:museic/core/configs/assets/app_images.dart';
import 'package:museic/core/configs/assets/app_vectors.dart';
import 'package:museic/core/configs/theme/app_colors.dart';
import 'package:museic/presentation/auth/pages/signup.dart';
import 'package:museic/presentation/auth/pages/signin.dart';

import '../../../common/widgets/appbar/app_bar.dart';

class SignupOrSigninPage extends StatelessWidget {
  const SignupOrSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground, // Dark mode için arka plan rengi
      body: Stack(
        children: [
          const BasicAppbar(),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AppVectors.topPattern),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(AppVectors.bottomPattern),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(AppImages.authBG)),
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppVectors.logo),
                    const SizedBox(
                      height: 55,
                    ),
                   
                    const SizedBox(
                      height: 21,
                    ),
                  
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: BasicAppButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            SignupPage()));
                              },
                              title: 'Register'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 1,
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                             SigninPage()));
                              },
                              child: const Text(
                                'Sign in',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white),
                              )),
                        )
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
