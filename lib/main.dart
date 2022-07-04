import 'package:flutter/material.dart';

void main() {
  runApp(const ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.purple[700],
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => TransferList(),
        '/form': (context) => TransferForm(),
      },
    );
  }
}

class TransferForm extends StatefulWidget {
  TransferForm({Key? key}) : super(key: key);

  @override
  State<TransferForm> createState() => _TransferFormState();
}

class _TransferFormState extends State<TransferForm> {
  final TextEditingController _controllerFieldAccountNumber =
      TextEditingController();

  final TextEditingController _controllerFieldValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new transfer'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
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

  final List<Transfer> _transferList = [];

  @override
  State<TransferList> createState() => _TransferListState();
}

class _TransferListState extends State<TransferList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfers'),
      ),
      body: Scrollbar(
        thickness: 8.0,
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 4.0),
          itemCount: widget._transferList.length,
          itemBuilder: (context, index) {
            return TransferItem(widget._transferList[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future data = Navigator.pushNamed(context, '/form');
          data.then((transfer) {
            if (transfer != null) {
              setState((){
                widget._transferList.add(transfer as Transfer);
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
