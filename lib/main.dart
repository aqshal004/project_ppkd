import 'package:flutter/material.dart'; // halaman pertama aplikasi kamu
import 'package:project_ppkd/view/bottom_nav.dart';
import 'package:project_ppkd/view/user/bottom_user.dart';
import 'package:project_ppkd/view/user/dashboard.dart';
import 'package:project_ppkd/view/login_posyandu.dart';
import 'package:project_ppkd/view/register_screen.dart';
import 'package:project_ppkd/view/splash_screen.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inisialisasi database untuk desktop
  // sqfliteFfiInit();
  // databaseFactory = databaseFactoryFfi;
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
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginPosyanduWidget(),
        '/register': (context) => const RegisterScreenWidget(),
        '/bottomnav': (context) => const BottomNav(),
        '/bottomuser':(context) => const BottomNavUser(),
        // '/admin': (context) => const DashboardAdminWidget(),
        '/user': (context) => const DashboardWidget(),
        
      },
      // home: const LoginPosyanduWidget(), // halaman awal
    );
  }
}
