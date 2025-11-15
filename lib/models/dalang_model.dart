class Dalang {
  final int id;
  final String nama;
  final String alamat;
  final String detailAlamat;
  final String fotoUrl;
  final double latitude;
  final double longitude;

  Dalang({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.detailAlamat,
    required this.fotoUrl,
    required this.latitude,
    required this.longitude,
  });

  factory Dalang.fromJson(Map<String, dynamic> json) {
    return Dalang(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      nama: json['nama'] ?? '',
      alamat: json['alamat'] ?? '',
      detailAlamat: json['detail_alamat'] ?? '',
      fotoUrl: json['foto_url'] ?? '',
      latitude: json['latitude'] is double
          ? json['latitude']
          : double.tryParse(json['latitude'].toString()) ?? 0,
      longitude: json['longitude'] is double
          ? json['longitude']
          : double.tryParse(json['longitude'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "alamat": alamat,
        "detail_alamat": detailAlamat,
        "foto_url": fotoUrl,
        "latitude": latitude,
        "longitude": longitude,
      };
}