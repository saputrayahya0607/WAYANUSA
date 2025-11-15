import 'dart:convert';
import 'package:http/http.dart' as http;

class DalangApi {
  static const String baseUrl = "http://localhost:8000/api";
  // NOTE:
  // Android emulator → 10.0.2.2
  // iOS emulator → localhost
  // Real device → pakai IP komputer (misal: 192.168.1.5)

  // ----------------------------
  // Helper parsing aman
  // ----------------------------
  static int parseInt(dynamic val) {
    if (val == null) return 0;
    if (val is int) return val;
    if (val is String) return int.tryParse(val) ?? 0;
    return 0;
  }

  static double? parseDouble(dynamic val) {
    if (val == null) return null;
    if (val is double) return val;
    if (val is int) return val.toDouble();
    if (val is String) return double.tryParse(val);
    return null;
  }

  // ----------------------------
  // GET all dalang
  // ----------------------------
  static Future<List<Map<String, dynamic>>> getAllDalang() async {
    final url = Uri.parse("$baseUrl/dalang");
    final res = await http.get(url);

    if (res.statusCode == 200) {
      // Response langsung array, bukan {'data': [...]}
      final dataList = jsonDecode(res.body) as List<dynamic>;

      return dataList.map<Map<String, dynamic>>((item) {
        if (item is! Map) return {};
        return {
          "id": parseInt(item['id']),
          "nama": item['nama'] ?? "",
          "alamat": item['alamat'] ?? "",
          "detail_alamat": item['detail_alamat'] ?? "",
          "foto_url": item['foto_url'] ?? "",
          "latitude": parseDouble(item['latitude']),
          "longitude": parseDouble(item['longitude']),
        };
      }).toList();
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  // ----------------------------
  // GET detail dalang
  // ----------------------------
  static Future<Map<String, dynamic>> getDalangById(int id) async {
    final url = Uri.parse("$baseUrl/dalang/$id");
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final decoded = jsonDecode(res.body);

      // Jika API hanya mengirim map langsung
      final dataMap = decoded as Map<String, dynamic>;

      return {
        "id": parseInt(dataMap['id']),
        "nama": dataMap['nama'] ?? "",
        "alamat": dataMap['alamat'] ?? "",
        "detail_alamat": dataMap['detail_alamat'] ?? "",
        "foto_url": dataMap['foto_url'] ?? "",
        "latitude": parseDouble(dataMap['latitude']),
        "longitude": parseDouble(dataMap['longitude']),
      };
    } else {
      throw Exception("Gagal mengambil detail");
    }
  }

  // ----------------------------
  // POST tambah dalang
  // ----------------------------
  static Future<bool> addDalang(Map<String, dynamic> data) async {
    final url = Uri.parse("$baseUrl/dalang");
    final res = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    return res.statusCode == 201;
  }

  // ----------------------------
  // DELETE dalang
  // ----------------------------
  static Future<bool> deleteDalang(int id) async {
    final url = Uri.parse("$baseUrl/dalang/$id");
    final res = await http.delete(url);

    return res.statusCode == 200;
  }
}