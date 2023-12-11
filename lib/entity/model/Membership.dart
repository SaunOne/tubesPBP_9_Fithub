class Memberships {
  int id;
  String jenisPaket;
  String Status;
  String mulaiBerlangganan;
  String akhirBerlangganan;

  Memberships({
    required this.id,
    required this.jenisPaket,
    required this.Status,
    required this.mulaiBerlangganan,
    required this.akhirBerlangganan,
  });

  Memberships.empty()
      : id = 0,
        jenisPaket = '',
        Status = '',
        mulaiBerlangganan = '',
        akhirBerlangganan = '';

  factory Memberships.fromJson(Map<String, dynamic> json) {
    return Memberships(
      id: json['id'],
      jenisPaket: json['jenis_paket'],
      Status: json['status'],
      mulaiBerlangganan: json['tanggal_mulai'],
      akhirBerlangganan: json['tanggal_berakhir'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'jenis_paket': jenisPaket,
    'status': Status,
    'tanggal_mulai': mulaiBerlangganan,
    'tanggal_berakhir': akhirBerlangganan,
  };


}