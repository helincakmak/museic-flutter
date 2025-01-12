import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:museic/alternative/helper/router.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.delayed(Duration(seconds: 2));
  String initialRoute;
  initialRoute = AppRouter.startPage;

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Sizer(builder: (context, orientation, deviceType) {
        return SafeArea(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: GoogleFonts.nunitoTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            initialRoute: initialRoute,
            onGenerateRoute: AppRouter.generateRoute,
          ),
        );
      }),
    );
  }
}

// Eski main dosyası
//
// import 'package:flutter/material.dart';
// import 'package:museic/core/configs/theme/app_theme.dart';
// import 'package:museic/presentation/pages/splash.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         theme: AppTheme.darkTheme,
//         debugShowCheckedModeBanner: false,
//         home: const SplashPage());
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }