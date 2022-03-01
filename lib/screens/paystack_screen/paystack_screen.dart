import 'package:flutter/material.dart';
import 'package:account_number_verify/app_library.dart';

class PayStackScreen extends StatefulWidget {
  const PayStackScreen({Key? key}) : super(key: key);

  @override
  _PayStackScreenState createState() => _PayStackScreenState();
}

class _PayStackScreenState extends State<PayStackScreen> {
  late Future<BankList> bankList;
  Future<GetAccountNumber>? accountNumber;
  final TextEditingController _controller = TextEditingController();

  String dropDownValue = 'Abbey Mortgage Bank';
  String? bankItemCode;

  @override
  void initState() {
    super.initState();
    bankList = getListOfBanks();
  }

  String? _getBankCode(List<Data> dataList, String name) {
    var bank = dataList.where((bankObject) {
      return bankObject.name == name;
    }).toList();

    for (var element in bank) {
      return element.code;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<BankList>(
          future: bankList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                var listOfBanks =
                    snapshot.data?.data.map((bank) => bank).toList();
                return DropdownButton<String>(
                  value: dropDownValue,
                  onChanged: (newValue) {
                    setState(() {
                      dropDownValue = newValue!;
                      bankItemCode = _getBankCode(listOfBanks!, dropDownValue);
                    });
                  },
                  items: listOfBanks?.map((bank) {
                    return DropdownMenuItem<String>(
                      value: bank.name,
                      child: Text(bank.name!),
                    );
                  }).toList(),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              }
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
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
                accountNumber: _controller.text,
                bankCode: bankItemCode ?? '000', // bankItemCode ?? '000'
              );
              print('dropDownValue = $dropDownValue');
              print('bank item code = $bankItemCode');
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
            return const Center();
          },
        ),
      ],
    );
  }
}
