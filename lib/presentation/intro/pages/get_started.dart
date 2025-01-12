import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:museic/common/widgets/button/basic_app_button.dart';
import 'package:museic/core/configs/assets/app_images.dart';
import 'package:museic/core/configs/assets/app_vectors.dart';
import 'package:museic/core/configs/theme/app_colors.dart';
import 'package:museic/presentation/auth/pages/sigup_or_siginin.dart';
import 'package:museic/presentation/pages/home_page.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      AppImages.introBG,
                    ))),
          ),
          Container(
            color: Colors.black.withOpacity(0.15),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            child: Column(
              children: [
                const Spacer(),
                const Text(
                  'Enjoy Listening To Music',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 25),
                ),
                const SizedBox(
                  height: 21,
                ),
                const Text(
                  'From the latest to the greatest hits, play your favorite tracks on museic now!',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                      fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                BasicAppButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const SignupOrSigninPage()));
                    },
                    title: 'Get Started')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
