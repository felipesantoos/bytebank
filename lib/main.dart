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
      home: TransferList(),
    );
  }
}

class TransferForm extends StatelessWidget {
  TransferForm({Key? key}) : super(key: key);

  final TextEditingController _controllerFieldAccountNumber =
      TextEditingController();
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
            CustomTextField(
              controller: _controllerFieldAccountNumber,
              labelText: 'Account number',
              hintText: '00000-0',
              prefixIcon: Icons.numbers,
            ),
            CustomTextField(
              controller: _controllerFieldValue,
              labelText: 'Value',
              hintText: '0.00',
              prefixIcon: Icons.monetization_on,
            ),
            Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                onPressed: () => _createTransfer(context),
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

  void _createTransfer(BuildContext context) {
    final String accountNumber = _controllerFieldAccountNumber.text;
    final double? value = double.tryParse(_controllerFieldValue.text);

    if (accountNumber.isNotEmpty && value != null) {
      Transfer transfer = Transfer(accountNumber: accountNumber, value: value);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transfer done with success!'),
        ),
      );
      Navigator.pop(context, transfer);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('One or more informed values are invalid!'),
        ),
      );
    }
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String hintText;
  final IconData? prefixIcon;

  const CustomTextField(
      {required this.controller,
      required this.labelText,
      required this.hintText,
      this.prefixIcon,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      ),
      style: const TextStyle(
        fontSize: 20.0,
      ),
      keyboardType: TextInputType.number,
    );
  }
}

class TransferList extends StatefulWidget {
  TransferList({Key? key}) : super(key: key);

  @override
  State<TransferList> createState() => _TransferListState();
}

class _TransferListState extends State<TransferList> {
  late List<Transfer> _transferList;

  @override
  void initState() {
    super.initState();
    _transferList = [
      Transfer(value: 100.0, accountNumber: '00000-1'),
      Transfer(value: 200.0, accountNumber: '00000-2'),
      Transfer(value: 300.0, accountNumber: '00000-3'),
      Transfer(value: 400.0, accountNumber: '00000-4'),
      Transfer(value: 500.0, accountNumber: '00000-5'),
      Transfer(value: 600.0, accountNumber: '00000-6'),
      Transfer(value: 700.0, accountNumber: '00000-7'),
      Transfer(value: 800.0, accountNumber: '00000-8'),
      Transfer(value: 900.0, accountNumber: '00000-9'),
      Transfer(value: 1000.0, accountNumber: '00001-0'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfers'),
        backgroundColor: Colors.purple.shade700,
      ),
      body: Scrollbar(
        thickness: 8.0,
        child: ListView.builder(
          itemCount: _transferList.length,
          itemBuilder: (context, index) {
            return TransferItem(_transferList[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future<Transfer?> data = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransferForm(),
            ),
          );
          data.then((transfer) {
            if (transfer != null) {
              setState((){
                _transferList.add(transfer);
              });
            }
          });
        },
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
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ListTile(
        onTap: () {},
        leading: const Icon(Icons.monetization_on),
        title: Text(_transfer.value.toString()),
        subtitle: Text(_transfer.accountNumber),
      ),
    );
  }
}

class Transfer {
  final String accountNumber;
  final double value;

  Transfer({required this.accountNumber, required this.value});

  @override
  String toString() {
    return 'Transfer{accountNumber: $accountNumber, value: $value}';
  }
}
