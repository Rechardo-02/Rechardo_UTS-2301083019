import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Text(
              'Warnet Afdil',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Pelanggan'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/pelanggan');
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text('Transaksi'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/transaksi');
            },
          ),
        ],
      ),
    );
  }
}
