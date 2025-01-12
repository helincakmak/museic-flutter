import 'package:flutter/material.dart';
import '../../../core/api_service.dart';
import 'package:museic/presentation/pages/songEntity.dart'; // Gerekli entity'ler için import
import 'package:museic/alternative/helper/router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // Giriş yapma fonksiyonu
  Future<void> _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showError('Lütfen tüm alanları doldurun.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/login/'),
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['token'] != null) {
          // Token'ı SharedPreferences ile sakla
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', responseData['token']);

          // Ana sayfaya yönlendir
          Navigator.pushReplacementNamed(context, AppRouter.homePageWrapper);
        } else {
          _showError('Token alınamadı. Giriş başarısız.');
        }
      } else {
        _showError('Giriş başarısız. Kod: ${response.statusCode}');
      }
    } catch (e) {
      _showError('Bir hata oluştu: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Token kontrol fonksiyonu
  Future<void> _checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null && token.isNotEmpty) {
      // Token varsa ana sayfaya yönlendir
      Navigator.pushReplacementNamed(context, AppRouter.homePageWrapper);
    }
  }

  @override
  void initState() {
    super.initState();
    _checkToken(); // Sayfa yüklendiğinde token kontrolü
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hata'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Tamam'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giriş Yap'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Şifre'),
              obscureText: true,
            ),
            SizedBox(height: 32),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    child: Text('Giriş Yap'),
                  ),
          ],
        ),
      ),
    );
  }
}
