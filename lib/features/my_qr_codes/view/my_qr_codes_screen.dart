import 'package:flutter/material.dart';

class MyQrCodesScreen extends StatelessWidget {
  const MyQrCodesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My QR Codes'),
      ),
      body: const Center(
        child: Text('My QR Codes Screen'),
      ),
    );
  }
}
