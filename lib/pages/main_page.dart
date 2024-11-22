import 'package:flutter/material.dart';
import 'package:latresmobile/components/loading.dart';
import 'package:latresmobile/components/my_appbar.dart';
import 'package:latresmobile/db/shared_preferences.dart';
import 'package:latresmobile/pages/home.dart';
import 'package:latresmobile/pages/login_page.dart';
import 'package:latresmobile/utils/theme.dart';

class MainPage extends StatefulWidget {
  final String username; // Menyimpan username yang diterima

  const MainPage({super.key, required this.username}); // Mengambil username dari constructor

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late bool _isLoading = false;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    DBHelper().setPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget body() {
      switch (_currentIndex) {
        case 0:
          return HomePage();

        default:
          return HomePage();
      }
    }

    return Stack(
      children: [
        Scaffold(
          appBar: myAppBar(
            context,
            title: 'Welcome, ${widget.username}!', // Menampilkan pesan sambutan di app bar
            automaticImplyLeading: false,
            action: [
              IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: NewsColors.red,
                ),
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  await Future.delayed((const Duration(seconds: 2)), () {
                    setState(() {
                      _isLoading = false;
                    });
                  });
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPage()));
                },
              ),
            ],
          ),
          body: body(), // Membuat body dari halaman
        ),
        LoadingScreen(loading: _isLoading),
      ],
    );
  }
}