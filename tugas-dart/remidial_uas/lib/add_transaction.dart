// add_transaction.dart
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../models/transaction.dart' as model;

class AddTransactionScreen extends StatefulWidget {
  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final titleController = TextEditingController();
  final dateController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  String selectedType = 'Pengeluaran';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Data')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildInput('Title', titleController),
              buildDropdown(),
              buildInput('Tanggal', dateController),
              buildInput('Jumlah', amountController),
              buildInput('Deskripsi', descriptionController, maxLines: 3),
              ElevatedButton(
                onPressed: () {
                  final tx = model.Transaction(
                    title: titleController.text,
                    type: selectedType,
                    date: dateController.text,
                    amount: int.tryParse(amountController.text) ?? 0,
                    description: descriptionController.text,
                  );

                  final db = FirebaseDatabase.instance.ref().child('transactions');
                  db.push().set({
                    'title': tx.title,
                    'type': tx.type,
                    'date': tx.date,
                    'amount': tx.amount,
                    'description': tx.description,
                  });

                  Navigator.pop(context);
                },
                child: Text('Simpan'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInput(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label :', style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.teal.shade300,
              border: InputBorder.none,
            ),
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget buildDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Jenis :', style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            color: Colors.teal.shade300,
            child: DropdownButton<String>(
              value: selectedType,
              dropdownColor: Colors.teal,
              iconEnabledColor: Colors.white,
              isExpanded: true,
              underline: SizedBox(),
              items: ['Pengeluaran', 'Pemasukan']
                  .map((e) => DropdownMenuItem(
                        child: Text(e, style: TextStyle(color: Colors.white)),
                        value: e,
                      ))
                  .toList(),
              onChanged: (value) => setState(() => selectedType = value!),
            ),
          )
        ],
      ),
    );
  }
}
