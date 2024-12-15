import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<dynamic> historyData = []; // Data untuk menyimpan hasil API
  bool isLoading = true; // State untuk loading

  @override
  void initState() {
    super.initState();
    fetchHistory(); // Panggil API saat inisialisasi
  }

  Future<void> fetchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id') ?? 0;

    if (userId == 0) {
      print("Error: user_id not found in SharedPreferences.");
      setState(() {
        isLoading = false;
      });
      return;
    }

    final url =
        Uri.parse('https://hairmate.smartrw.my.id/api/scan-history/get');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_id': userId}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success']) {
          setState(() {
            historyData = responseData['data'];
            isLoading = false;
          });
        } else {
          print('Error fetching history: ${responseData['message']}');
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print('Error fetching history: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching history: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/arrow.png',
            width: 40,
            height: 40,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'History',
          style: TextStyle(
            color: Color(0xFF1B1A55),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : historyData.isEmpty
              ? const Center(
                  child: Text('No history found.'),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: List.generate(historyData.length, (index) {
                      final item = historyData[index];
                      return _buildHairCutItem(
                        context,
                        item['image'],
                        item['title'],
                        item['description'],
                        item['scan_date'],
                        item['hairstyles'], // Tiga nama haircut
                      );
                    }),
                  ),
                ),
    );
  }

  Widget _buildHairCutItem(
    BuildContext context,
    String imagePath,
    String name,
    String description,
    String date,
    List<dynamic> hairstyles, // List tiga haircut dari backend
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xFF1B1A55),
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          // Gambar dan konten
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imagePath,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul dan tanggal
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            color: Color(0xFF1B1A55),
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          date,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 149, 148, 148),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    // Tiga tombol haircut
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection:
                                Axis.horizontal, // Scroll ke arah horizontal
                            child: Row(
                              children: List.generate(
                                hairstyles.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: _buildShapeButton(
                                      hairstyles[index]['name']),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShapeButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF1B1A55), width: 2),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF1B1A55),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
