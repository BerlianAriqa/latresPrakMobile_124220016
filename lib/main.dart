import 'package:flutter/material.dart';
import 'package:latresmobile/pages/login_page.dart';
import 'utils/theme.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News Apps',
      theme: ThemeData(
        fontFamily: 'QuicksandRegular',
        bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: NewsColors.primary,
        focusColor: NewsColors.primary,
        dividerColor: Colors.transparent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}
