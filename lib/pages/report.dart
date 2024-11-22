import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:latresmobile/components/my_appbar.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<dynamic> reports = [];
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    fetchReports();
  }

  Future<void> fetchReports() async {
    try {
      final response = await _dio.get('https://api.spaceflightnewsapi.net/v4/reports/');
      setState(() {
        reports = response.data['results'];
      });
    } catch (e) {
      print('Error fetching reports: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        context,
        title: 'Report', // Mengatur judul untuk AppBar
        leading: false, // Tidak menampilkan tombol kembali di daftar
      ),
      body: reports.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final reportItem = reports[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 5, // Menambahkan bayangan pada kartu
                  child: InkWell(
                    onTap: () {
                      // Navigasi ke halaman detail report
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReportDetailScreen(reportItem: reportItem),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          if (reportItem['image_url'] != null)
                            Image.network(
                              reportItem['image_url'],
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
                                  reportItem['title'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  reportItem['summary'],
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

class ReportDetailScreen extends StatelessWidget {
  final dynamic reportItem;

  ReportDetailScreen({required this.reportItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(reportItem['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (reportItem['image_url'] != null)
              Image.network(reportItem['image_url'], width: double.infinity),
            SizedBox(height: 16.0),
            Text(reportItem['summary']),
            SizedBox(height: 16.0),
            Text('Published at: ${reportItem['published_at']}'),
            SizedBox(height: 16.0),
            Text('Source: ${reportItem['news_site']}'),
            SizedBox(height: 16.0),
            Text('Read more: ', style: TextStyle(fontWeight: FontWeight.bold)),
            GestureDetector(
              child: Text(reportItem['url'], style: TextStyle(color: Colors.blue)),
              onTap: () {
                // Menangani aksi jika perlu
              },
            ),
          ],
        ),
      ),
    );
  }
}