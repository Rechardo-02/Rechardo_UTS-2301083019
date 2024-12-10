class Warnet {

  final String kodeTransaksi;   
  final String namaPelanggan;   
  final String jenisPelanggan;  
  final DateTime tglMasuk;      
  final DateTime jamMasuk;      
  final DateTime jamKeluar;     
  final double tarif;           

  
  double diskon = 0;            
  double totalBayar = 0;        

  
  Warnet({
    required this.kodeTransaksi,
    required this.namaPelanggan,
    required this.jenisPelanggan,
    required this.tglMasuk,
    required this.jamMasuk,
    required this.jamKeluar,
    required this.tarif,
  }) {
    hitungBayar(); 
  }

  
  void hitungBayar() {
    /
    final duration = jamKeluar.difference(jamMasuk);
    final lamaJam = duration.inMinutes / 60.0;

    
    double subTotal = lamaJam * tarif;

    
    if (jenisPelanggan == "VIP" && lamaJam > 2) {
      diskon = subTotal * 0.02; 
    } else if (jenisPelanggan == "GOLD" && lamaJam > 2) {
      diskon = subTotal * 0.05; 
    }

   
    totalBayar = subTotal - diskon;
  }

  
  @override
  String toString() {
    return '''
    ==============================
    Kode Transaksi : $kodeTransaksi
    Nama Pelanggan : $namaPelanggan
    Jenis Pelanggan: $jenisPelanggan
    Tanggal Masuk  : ${tglMasuk.toLocal()}
    Jam Masuk      : ${jamMasuk.toLocal()}
    Jam Keluar     : ${jamKeluar.toLocal()}
    Lama Waktu     : ${(jamKeluar.difference(jamMasuk).inMinutes / 60.0).toStringAsFixed(2)} jam
    Tarif per Jam  : Rp${tarif.toStringAsFixed(2)}
    Diskon         : Rp${diskon.toStringAsFixed(2)}
    Total Bayar    : Rp${totalBayar.toStringAsFixed(2)}
    ==============================
    ''';
  }
}
