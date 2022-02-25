import 'package:flutter/material.dart';

import 'model/BankList.dart';
import 'network/api_paystack.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<BankList> bankList;
  String dropDownValue = 'Abbey Mortgage Bank';

  @override
  void initState() {
    super.initState();
    bankList = getListOfBanks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PayStack API'),
      ),
      body: FutureBuilder<BankList>(
        future: bankList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var listOfBankNames =
                  snapshot.data?.data.map((bank) => bank.name).toList();
              return DropdownButton<String>(
                value: dropDownValue,
                onChanged: (newValue) {
                  setState(() {
                    dropDownValue = newValue!;
                  });
                },
                items: listOfBankNames?.map((bankName) {
                  return DropdownMenuItem<String>(
                    value: bankName,
                    child: Text(bankName!),
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
    );
  }
}
