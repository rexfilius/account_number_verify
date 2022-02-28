import 'package:account_number_verify/network/api_paystack.dart';
import 'package:flutter/material.dart';

import '../model/bank_list.dart';
import '../model/get_account_number.dart';

class ConfirmAccountWidget extends StatefulWidget {
  const ConfirmAccountWidget({Key? key}) : super(key: key);

  @override
  _ConfirmAccountWidgetState createState() => _ConfirmAccountWidgetState();
}

class _ConfirmAccountWidgetState extends State<ConfirmAccountWidget> {
  late Future<BankList> bankList;
  Future<GetAccountNumber>? accountNumber;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    bankList = getListOfBanks();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Your Account Number?',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              accountNumber = getAccountNumber(
                accountNumber: int.parse(_controller.text),
                bankCode: 50211,
              );
            });
          },
          child: const Text('Confirm Number'),
        ),
        // (50211-KudaBank-2009943490) (058-GTB-0567482425)
        FutureBuilder<GetAccountNumber>(
          future: accountNumber,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final number = snapshot.data?.data.accountNumber;
                final name = snapshot.data?.data.accountName;
                return Text('$name $number');
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
            }
            return const CircularProgressIndicator();
          },
        )
      ],
    );
  }
}
