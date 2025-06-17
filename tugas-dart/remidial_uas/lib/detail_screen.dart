// detail_screen.dart
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class DetailScreen extends StatelessWidget {
  final Transaction tx;

  DetailScreen(this.tx);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Gambar telah dihapus sesuai permintaan
            buildInfo('Title', tx.title),
            buildInfo('Jenis', tx.type),
            buildInfo('Tanggal', tx.date),
            buildInfo('Jumlah', tx.amount.toString()),
            buildInfo('Deskripsi', tx.description),
          ],
        ),
      ),
    );
  }

  Widget buildInfo(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label :', style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            color: Colors.teal.shade300,
            child: Text(value, style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}
