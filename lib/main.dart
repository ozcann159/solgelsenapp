import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:solgensenapp/core/theme/app_theme.dart';
import 'package:solgensenapp/features/dashboard/presentation/pages/home_page.dart';
import 'package:solgensenapp/features/splash/splash_page.dart';
import 'package:solgensenapp/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solgensen ERP',
      theme: AppTheme.lightTheme,
      home: const AccountListPage(),
      //SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
