import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Transfers'),
        backgroundColor: Colors.purple[700],
      ),
      body: const TransferList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        backgroundColor: Colors.purple[700],
        child: const Icon(Icons.add),
      ),
    ),
  ));
}

class TransferList extends StatelessWidget {
  const TransferList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        TransferItem(Transfer(value: 100.0, accountNumber: '12345-6')),
        TransferItem(Transfer(value: 200.0, accountNumber: '12346-7')),
        TransferItem(Transfer(value: 300.0, accountNumber: '12347-8')),
        TransferItem(Transfer(value: 400.0, accountNumber: '12348-9')),
        TransferItem(Transfer(value: 500.0, accountNumber: '12349-1')),
      ],
    );
  }
}

class TransferItem extends StatelessWidget {

  final Transfer _transfer;

  const TransferItem(this._transfer, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child:
      ListTile(
        onTap: () {},
        leading: const Icon(Icons.monetization_on),
        title: Text(_transfer.value.toString()),
        subtitle: Text(_transfer.accountNumber),
      ),
    );
  }
}

class Transfer {
  final double value;
  final String accountNumber;

  Transfer({required this.value, required this.accountNumber});
}
