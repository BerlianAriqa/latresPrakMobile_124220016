import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:latresmobile/components/my_appbar.dart';

class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  List<dynamic> blogs = [];
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    fetchBlogs();
  }

  Future<void> fetchBlogs() async {
    try {
      final response = await _dio.get('https://api.spaceflightnewsapi.net/v4/blogs/');
      setState(() {
        // Filter untuk hanya menyimpan blog yang memiliki gambar
        blogs = response.data['results'].where((blog) => blog['image_url'] != null && blog['image_url'].isNotEmpty).toList();
      });
    } catch (e) {
      print('Error fetching blogs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        context,
        title: 'Blogs', // Mengatur judul untuk AppBar
        leading: false, // Jika Anda tidak ingin menampilkan tombol kembali
      ),
      body: blogs.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                final blogItem = blogs[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 5, // Menambahkan bayangan pada kartu
                  child: InkWell(
                    onTap: () {
                      // Navigasi ke halaman detail blog
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlogDetailScreen(blogItem: blogItem),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Image.network(
                            blogItem['image_url'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  blogItem['title'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  blogItem['summary'],
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

class BlogDetailScreen extends StatelessWidget {
  final dynamic blogItem;

  BlogDetailScreen({required this.blogItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        context,
        title: blogItem['title'],
        leading: true, // Menampilkan tombol kembali
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (blogItem['image_url'] != null && blogItem['image_url'].isNotEmpty)
              Image.network(blogItem['image_url'], width: double.infinity),
            SizedBox(height: 16.0),
            Text(blogItem['summary']),
            SizedBox(height: 16.0),
            Text('Published at: ${blogItem['published_at']}'),
            SizedBox(height: 16.0),
            Text('Source: ${blogItem['news_site']}'),
          ],
        ),
      ),
    );
  }
}