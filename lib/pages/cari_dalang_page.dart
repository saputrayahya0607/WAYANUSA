import 'package:flutter/material.dart';
import 'package:wayanusa/services/dalang_api.dart';
import 'package:wayanusa/models/dalang_model.dart';
import 'detail_dalang_page.dart';
import 'dart:convert';

class CariDalangPage extends StatefulWidget {
  const CariDalangPage({Key? key}) : super(key: key);

  @override
  State<CariDalangPage> createState() => _CariDalangPageState();
}

class _CariDalangPageState extends State<CariDalangPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Dalang> _dalangList = [];
  String _searchText = "";
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadDalang();
  }

  void loadDalang() async {
    setState(() => loading = true);
    try {
      // Ambil dari API (List<Map>)
      final res = await DalangApi.getAllDalang();

      // Convert Map → Dalang
      _dalangList = res.map((json) => Dalang.fromJson(json)).toList();

      // Debug: print daftar dalang sebagai JSON
      final listJson = _dalangList.map((d) => d.toJson()).toList();
      print("HASIL API: ${jsonEncode(listJson)}");

    } catch (e, stack) {
      print("Error API: $e");
      print(stack);
    } finally {
      setState(() => loading = false);
    }
  }
  @override
  Widget build(BuildContext context) {
    final filteredList = _dalangList.where((d) {
      return d.nama.toLowerCase().contains(_searchText.toLowerCase());
    }).toList();

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
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Cari Dalang",
                      prefixIcon: const Icon(Icons.search, color: Colors.black54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() => _searchText = value);
                    },
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final d = filteredList[index];
                        return DalangCard(dalang: d);
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
  final Dalang dalang;
  const DalangCard({Key? key, required this.dalang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailDalangPage(
              nama: dalang.nama,
              alamat: dalang.alamat,
              detailAlamat: dalang.detailAlamat,
              gambar: dalang.fotoUrl,
              latitude: dalang.latitude,
              longitude: dalang.longitude,
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
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 3)),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: dalang.fotoUrl.isNotEmpty
                  ? NetworkImage(dalang.fotoUrl)
                  : const AssetImage("assets/default_profile.png") as ImageProvider,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dalang.nama,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                  const SizedBox(height: 4),
                  Text(dalang.alamat,
                      style: const TextStyle(fontSize: 13, color: Colors.black54)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}