import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../models/warnet.dart';

class TransaksiScreen extends StatefulWidget {
  const TransaksiScreen({super.key});

  @override
  State<TransaksiScreen> createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  final List<Warnet> _transaksiList = [];
  final _formKey = GlobalKey<FormState>();
  final _kodeController = TextEditingController();
  final _namaController = TextEditingController();
  String _selectedJenisPelanggan = 'VIP';
  DateTime _selectedDate = DateTime.now();
  final _jamMasukController = TextEditingController();
  final _jamKeluarController = TextEditingController();
  final _tarifController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    _kodeController.dispose();
    _namaController.dispose();
    _jamMasukController.dispose();
    _jamKeluarController.dispose();
    _tarifController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaksi Warnet'),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _kodeController,
                  decoration:
                      const InputDecoration(labelText: 'Kode Transaksi'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon masukkan kode transaksi';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _namaController,
                  decoration:
                      const InputDecoration(labelText: 'Nama Pelanggan'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon masukkan nama pelanggan';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: _selectedJenisPelanggan,
                  decoration:
                      const InputDecoration(labelText: 'Jenis Pelanggan'),
                  items: const [
                    DropdownMenuItem(value: 'VIP', child: Text('VIP')),
                    DropdownMenuItem(value: 'GOLD', child: Text('GOLD')),
                    DropdownMenuItem(value: 'REGULAR', child: Text('REGULAR')),
                  ],
                  onChanged: (String? value) {
                    setState(() {
                      _selectedJenisPelanggan = value!;
                    });
                  },
                ),
                ListTile(
                  title: Text(
                      'Tanggal: ${_selectedDate.toLocal().toString().split(' ')[0]}'),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () => _selectDate(context),
                ),
                TextFormField(
                  controller: _jamMasukController,
                  decoration:
                      const InputDecoration(labelText: 'Jam Masuk (HH:MM)'),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon masukkan jam masuk';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _jamKeluarController,
                  decoration:
                      const InputDecoration(labelText: 'Jam Keluar (HH:MM)'),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon masukkan jam keluar';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _tarifController,
                  decoration: const InputDecoration(labelText: 'Tarif per Jam'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mohon masukkan tarif';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final jamMasukParts = _jamMasukController.text.split(':');
                      final jamKeluarParts =
                          _jamKeluarController.text.split(':');

                      final jamMasukDateTime = DateTime(
                        _selectedDate.year,
                        _selectedDate.month,
                        _selectedDate.day,
                        int.parse(jamMasukParts[0]),
                        int.parse(jamMasukParts[1]),
                      );

                      final jamKeluarDateTime = DateTime(
                        _selectedDate.year,
                        _selectedDate.month,
                        _selectedDate.day,
                        int.parse(jamKeluarParts[0]),
                        int.parse(jamKeluarParts[1]),
                      );

                      final tarif = double.parse(_tarifController.text);

                      final transaksi = Warnet(
                        kodeTransaksi: _kodeController.text,
                        namaPelanggan: _namaController.text,
                        jenisPelanggan: _selectedJenisPelanggan,
                        tglMasuk: _selectedDate,
                        jamMasuk: jamMasukDateTime,
                        jamKeluar: jamKeluarDateTime,
                        tarif: tarif,
                      );

                      setState(() {
                        _transaksiList.add(transaksi);
                        _kodeController.clear();
                        _namaController.clear();
                        _jamMasukController.clear();
                        _jamKeluarController.clear();
                        _tarifController.clear();
                      });

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Transaksi Ditambahkan'),
                          content: Text(
                            'Nama: ${transaksi.namaPelanggan}\n'
                            'Kode: ${transaksi.kodeTransaksi}\n'
                            'Jenis: ${transaksi.jenisPelanggan}\n'
                            'Tanggal: ${transaksi.tglMasuk.toLocal().toString().split(' ')[0]}\n'
                            'Jam Masuk: ${transaksi.jamMasuk.hour}:${transaksi.jamMasuk.minute}\n'
                            'Jam Keluar: ${transaksi.jamKeluar.hour}:${transaksi.jamKeluar.minute}\n'
                            'Diskon: Rp${transaksi.diskon.toStringAsFixed(2)}\n'
                            'Total: Rp${transaksi.totalBayar.toStringAsFixed(2)}',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text('Tambah Transaksi'),
                ),
                const SizedBox(height: 20),
                Text('Daftar Transaksi:',
                    style: Theme.of(context).textTheme.headlineSmall),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _transaksiList.length,
                  itemBuilder: (context, index) {
                    final transaksi = _transaksiList[index];
                    return ListTile(
                      title: Text(transaksi.namaPelanggan),
                      subtitle: Text(
                        'Kode: ${transaksi.kodeTransaksi}\n'
                        'Jenis: ${transaksi.jenisPelanggan}\n'
                        'Tanggal: ${transaksi.tglMasuk.toLocal().toString().split(' ')[0]}\n'
                        'Jam Masuk: ${transaksi.jamMasuk.hour}:${transaksi.jamMasuk.minute}\n'
                        'Jam Keluar: ${transaksi.jamKeluar.hour}:${transaksi.jamKeluar.minute}\n'
                        'Diskon: Rp${transaksi.diskon.toStringAsFixed(2)}\n'
                        'Total: Rp${transaksi.totalBayar.toStringAsFixed(2)}',
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
