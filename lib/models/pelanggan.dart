class Pelanggan {
  
  final String kode; 
  final String nama; 

  
  const Pelanggan({
    required this.kode,
    required this.nama,
  });

  
  @override
  String toString() {
    return '''
    ======================
    Kode Pelanggan : $kode
    Nama Pelanggan : $nama
    ======================
    ''';
  }
}
