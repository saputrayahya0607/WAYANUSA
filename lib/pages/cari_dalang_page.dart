import 'package:flutter/material.dart';
import 'detail_dalang_page.dart'; // pastikan file ini ada di folder yang sama

class CariDalangPage extends StatefulWidget {
  const CariDalangPage({Key? key}) : super(key: key);

  @override
  State<CariDalangPage> createState() => _CariDalangPageState();
}

class _CariDalangPageState extends State<CariDalangPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _dalangList = [
    {
      "nama": "Ki Purnomo (Padepokan Ora Aji)",
      "alamat": "Kramat.Kec.Kramat.Kab.Tegal",
      "gambar": "assets/dalang.png",
      "detailAlamat":
          "Jl. Raya Kramat No.91, Kramat, Kec. Kramat, Kabupaten Tegal, Jawa Tengah 52181"
    },
    {
      "nama": "Dalang Deleng",
      "alamat": "Kramat.Kec.Kramat.Kab.Tegal",
      "gambar": "assets/dalang.png",
      "detailAlamat":
          "Jl. Raya Kramat No.50, Kramat, Kec. Kramat, Kabupaten Tegal, Jawa Tengah 52181"
    },
    {
      "nama": "Dalang Deleng",
      "alamat": "Kramat.Kec.Kramat.Kab.Tegal",
      "gambar": "assets/dalang.png",
      "detailAlamat":
          "Jl. Raya Kramat No.50, Kramat, Kec. Kramat, Kabupaten Tegal, Jawa Tengah 52181"
    },
  ];

  String _searchText = "";

  @override
  Widget build(BuildContext context) {
    final filteredList = _dalangList
        .where((dalang) =>
            dalang["nama"]!.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();

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
          "Mencari Dalang",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔍 Search Field
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Cari Video",
                prefixIcon: const Icon(Icons.search, color: Colors.black54),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // 📜 List Dalang
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final dalang = filteredList[index];
                  return DalangCard(
                    nama: dalang["nama"]!,
                    alamat: dalang["alamat"]!,
                    gambar: dalang["gambar"]!,
                    detailAlamat: dalang["detailAlamat"]!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DalangCard extends StatelessWidget {
  final String nama;
  final String alamat;
  final String gambar;
  final String detailAlamat;

  const DalangCard({
    Key? key,
    required this.nama,
    required this.alamat,
    required this.gambar,
    required this.detailAlamat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail dalang
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailDalangPage(
              nama: nama,
              alamat: alamat,
              gambar: gambar,
              detailAlamat: detailAlamat,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.brown.shade200),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Gambar Dalang
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                gambar,
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 14),

            // Nama & Alamat
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    alamat,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}