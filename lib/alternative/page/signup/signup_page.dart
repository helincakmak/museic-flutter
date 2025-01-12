import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:museic/alternative/helper/router.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  PageController _controller = PageController();
  int _currentPage = 0;
  bool _isChecked1 = false;
  bool _isChecked2 = false;

  // TextEditingController'lar
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  String selectedGender = '';

  // Kullanıcı kaydı için API çağrısı
  Future<void> registerUser(
      String email, String password, String gender, String username) async {
    if (gender.isEmpty) {
      print('Hata: Cinsiyet seçilmedi.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lütfen bir cinsiyet seçin.')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/register/'), // API endpoint
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username, 
          'email': email,
          'password': password,
          'gender': gender,
        }),
      );

      if (response.statusCode == 201) {
        print('Kayıt başarılı!');
        Navigator.pushReplacementNamed(context, AppRouter.homePageWrapper);
      } else {
        print('Hata: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Kayıt işlemi başarısız: ${response.body}')),
        );
      }
    } catch (e) {
      print('Bağlantı hatası: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bağlantı hatası!')),
      );
    }
  }

  void _nextPage() {
    if (_currentPage < 3) {
      setState(() {
        _currentPage++;
        _controller.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xFF111111),
        body: PageView(
          controller: _controller,
          physics: NeverScrollableScrollPhysics(),
          children: [
            _buildEmailPage(),
            _buildPasswordPage(),
            _buildGenderPage(),
            _buildUserNamePage(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailPage() {
    return _buildPage(
      title: "What's your email?",
      hintText: "Enter your email",
      controller: emailController,
      onNext: () {
        if (emailController.text.isEmpty ||
            !emailController.text.contains('@')) {
          print('Hata: Geçersiz e-posta.');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Lütfen geçerli bir e-posta adresi girin.")),
          );
        } else {
          _nextPage();
        }
      },
    );
  }

  Widget _buildPasswordPage() {
    return _buildPage(
      title: "Create a password",
      hintText: "Use at least 8 characters",
      controller: passwordController,
      obscureText: true,
      onNext: () {
        if (passwordController.text.length < 8) {
          print('Hata: Şifre 8 karakterden kısa.');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text("Şifre en az 8 karakter uzunluğunda olmalıdır.")),
          );
        } else {
          _nextPage();
        }
      },
    );
  }

  Widget _buildGenderPage() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBackButton(),
            SizedBox(height: 5.h),
            Text(
              "What's your gender?",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 2.h),
            DropdownButtonFormField<String>(
              items: ['Male', 'Female', 'Non-binary'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.black)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[800],
                hintText: 'Select your gender',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
              ),
              dropdownColor: Colors.grey[800],
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 2.h),
            _buildNextButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserNamePage() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBackButton(),
            SizedBox(height: 5.h),
            Text(
              "What's your name?",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 2.h),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[800],
                hintText: 'Enter your  User name',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 2.h),
            _buildCreateAccountButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPage({
    required String title,
    required String hintText,
    required TextEditingController controller,
    bool obscureText = false,
    required VoidCallback onNext,
  }) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBackButton(),
            SizedBox(height: 5.h),
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 2.h),
            TextField(
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[800],
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 2.h),
            _buildNextButton(onPressed: onNext),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        if (_currentPage > 0) {
          setState(() {
            _currentPage--;
            _controller.previousPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        }
      },
    );
  }

  Widget _buildNextButton({void Function()? onPressed}) {
    return GestureDetector(
      onTap: onPressed ?? _nextPage,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 1.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.green,
        ),
        child: Center(
          child: Text(
            "Next",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildCreateAccountButton() {
    return GestureDetector(
      onTap: () {
        print('Kayıt süreci başlatılıyor...');
        registerUser(
          emailController.text,
          passwordController.text,
          selectedGender,
          usernameController.text,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            "Create Account",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
