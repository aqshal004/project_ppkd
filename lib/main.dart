import 'package:flutter/material.dart'; // halaman pertama aplikasi kamu
import 'package:project_ppkd/preferences/preferences_handler.dart';
import 'package:project_ppkd/view/bottom_nav.dart';
import 'package:project_ppkd/view/dashboard_admin.dart';
import 'package:project_ppkd/view/drawer.dart';
import 'package:project_ppkd/view/login_posyandu.dart';
import 'package:project_ppkd/view/register_screen.dart';
import 'package:project_ppkd/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // lakukan inisialisasi yang diperlukan di sini
  // final isLoggedIn = await PreferencesHandler.isLogin(); // kalau kamu punya fungsi init SharedPreferences

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final bool isLoggedIn;
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Posyandu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreenWidget(),
        '/login': (context) => const LoginPosyanduWidget(),
        '/register': (context) => const RegisterScreenWidget(),
        '/bottomnav': (context) => const BottomNav(),
        '/admin': (context) => const DashboardAdminWidget(),
        
      },
      // home: const LoginPosyanduWidget(), // halaman awal
    );
  }
}
