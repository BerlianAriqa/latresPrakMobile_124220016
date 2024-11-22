import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:latresmobile/components/my_appbar.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<dynamic> news = [];
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      final response = await _dio.get('https://api.spaceflightnewsapi.net/v4/articles/');
      setState(() {
        news = response.data['results'];
      });
    } catch (e) {
      // Penanganan error
      print('Error fetching news: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        context,
        title: 'News', // Mengatur judul untuk AppBar
        leading: false, // Tidak menampilkan tombol kembali di daftar
      ),
      body: news.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: news.length,
              itemBuilder: (context, index) {
                final newsItem = news[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 5, // Menambahkan bayangan
                  child: InkWell(
                    onTap: () {
                      // Navigasi ke halaman detail berita
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailScreen(newsItem: newsItem),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          if (newsItem['image_url'] != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Image.network(
                                newsItem['image_url'],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  newsItem['title'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  newsItem['summary'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class NewsDetailScreen extends StatelessWidget {
  final dynamic newsItem;

  NewsDetailScreen({required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        context,
        title: newsItem['title'], // Mengatur judul sesuai dengan berita yang dipilih
        leading: true, // Menampilkan tombol kembali
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (newsItem['image_url'] != null)
              Image.network(newsItem['image_url'], width: double.infinity),
            SizedBox(height: 16.0),
            Text(newsItem['summary']),
            SizedBox(height: 16.0),
            Text('Published at: ${newsItem['published_at']}'),
            SizedBox(height: 16.0),
            Text('Updated at: ${newsItem['updated_at']}'),
          ],
        ),
      ),
    );
  }
}