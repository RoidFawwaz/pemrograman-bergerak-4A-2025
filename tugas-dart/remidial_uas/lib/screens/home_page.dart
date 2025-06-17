// home_page.dart
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../models/transaction.dart' as model;
import '../add_transaction.dart';
import '../detail_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    final snapshot = await FirebaseDatabase.instance.ref('transactions').get();

    model.transactions.clear();

    if (snapshot.exists && snapshot.value != null) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);

      data.forEach((key, value) {
        if (value is Map) {
          final txMap = Map<String, dynamic>.from(value as Map);
          model.transactions.add(model.Transaction(
            title: txMap['title'] ?? '',
            type: txMap['type'] ?? '',
            date: txMap['date'] ?? '',
            amount: txMap['amount'] ?? 0,
            description: txMap['description'] ?? '',
          ));
        }
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int balance = model.transactions.fold(0, (sum, item) {
      return item.type == 'Pemasukan' ? sum + item.amount : sum - item.amount;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Saldo : $balance', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.indigo.shade900,
        elevation: 0,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : model.transactions.isEmpty
              ? Center(child: Text('Belum ada data'))
              : ListView(
                  padding: EdgeInsets.all(10),
                  children: model.transactions
                      .map((tx) => buildCard(context, tx))
                      .toList(),
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo.shade900,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddTransactionScreen()),
        ).then((_) => fetchTransactions()),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildCard(BuildContext context, model.Transaction tx) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DetailScreen(tx)),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.teal.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.asset(
                'assets/images/note.png',
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      tx.type,
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Tanggal : ${tx.date}',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Rp. ${tx.amount}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
