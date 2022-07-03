import 'package:flutter/material.dart';

void main() {
  runApp(const ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: TransferForm(),
      ),
    );
  }
}


class TransferForm extends StatelessWidget {
  TransferForm({Key? key}) : super(key: key);

  final TextEditingController _controllerFieldAccountNumber = TextEditingController();
  final TextEditingController _controllerFieldValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new transfer'),
        backgroundColor: Colors.purple.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: _controllerFieldAccountNumber,
              decoration: const InputDecoration(
                labelText: 'Account number',
                hintText: '00000-0',
                prefixIcon: Icon(Icons.numbers),
              ),
              style: const TextStyle(
                fontSize: 20.0,
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _controllerFieldValue,
              decoration: const InputDecoration(
                labelText: 'Value',
                hintText: '0.00',
                prefixIcon: Icon(Icons.monetization_on),
              ),
              style: const TextStyle(
                fontSize: 20.0,
              ),
              keyboardType: TextInputType.number,
            ),
            Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                onPressed: () {
                  debugPrint(_controllerFieldAccountNumber.text);
                  debugPrint(_controllerFieldValue.text);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) {
                    return Colors.purple.shade700;
                  }),
                ),
                child: const Text('Confirm'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class TransferList extends StatelessWidget {
  const TransferList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfers'),
        backgroundColor: Colors.purple.shade700,
      ),
      body: ListView(
        children: <Widget>[
          TransferItem(Transfer(value: 100.0, accountNumber: '12345-6')),
          TransferItem(Transfer(value: 200.0, accountNumber: '12346-7')),
          TransferItem(Transfer(value: 300.0, accountNumber: '12347-8')),
          TransferItem(Transfer(value: 400.0, accountNumber: '12348-9')),
          TransferItem(Transfer(value: 500.0, accountNumber: '12349-1')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        backgroundColor: Colors.purple.shade700,
        child: const Icon(Icons.add),
      ),
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
