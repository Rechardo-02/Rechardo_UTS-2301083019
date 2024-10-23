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
    final difference = jamKeluar.difference(jamMasuk);
    final lama = difference.inMinutes / 60.0;

    double subTotal = lama * tarif;

    if (jenisPelanggan == "VIP" && lama > 2) {
      diskon = subTotal * 0.02; // Diskon 2%
    } else if (jenisPelanggan == "GOLD" && lama > 2) {
      diskon = subTotal * 0.05; // Diskon 5%
    }

    totalBayar = subTotal - diskon;
  }
}
