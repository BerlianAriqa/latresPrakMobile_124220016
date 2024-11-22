import 'package:flutter/material.dart';
import '../utils/theme.dart';

AppBar myAppBar(
  BuildContext context, {
  String? username, // Menambahkan parameter username
  String title = '', // Menambahkan parameter title
  List<Widget>? action,
  bool leading = false,
  VoidCallback? leadingAction,
  ImageProvider? image,
  bool automaticImplyLeading = true,
}) {
  return AppBar(
    centerTitle: true,
    title: Text(
      username != null ? 'Welcome, $username!' : title, // Menampilkan pesan sambutan atau title
      style: NewsFonts(context).appbarTitle.copyWith(color: Colors.white), // Mengubah warna teks menjadi putih
    ),
    actions: action,
    elevation: 0,
    automaticallyImplyLeading: automaticImplyLeading,
    backgroundColor: NewsColors.primary, // Menggunakan warna background yang telah ditetapkan
    leading: leading
        ? IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        : null,
  );
}