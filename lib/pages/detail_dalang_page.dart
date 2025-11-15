import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailDalangPage extends StatelessWidget {
  final String nama;
  final String alamat;
  final String detailAlamat;
  final String gambar;
  final double latitude;
  final double longitude;

  const DetailDalangPage({
    super.key,
    required this.nama,
    required this.alamat,
    required this.detailAlamat,
    required this.gambar,
    required this.latitude,
    required this.longitude,
  });

  Future<void> _bukaGoogleMaps() async {
    final Uri url = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Tidak dapat membuka Google Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.brown),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Detail Dalang",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // FOTO DALANG
              CircleAvatar(
                radius: 75,
                backgroundColor: Colors.grey[200],
                backgroundImage: gambar.isNotEmpty
                    ? NetworkImage(gambar)
                    : const AssetImage("assets/default_profile.png")
                        as ImageProvider,
              ),

              const SizedBox(height: 20),

              // NAMA DALANG
              Text(
                nama,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 10),

              // ALAMAT UTAMA
              Text(
                alamat,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 4),

              // DETAIL ALAMAT
              Text(
                detailAlamat,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // TOMBOL GOOGLE MAPS
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _bukaGoogleMaps,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.map, color: Colors.white),
                  label: const Text(
                    "Buka di Google Maps",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}