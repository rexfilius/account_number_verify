import 'package:flutter/material.dart';

import '../model/bank_list.dart';
import '../network/api_paystack.dart';

class BankListDropDownMenu extends StatefulWidget {
  const BankListDropDownMenu({Key? key}) : super(key: key);

  @override
  _BankListDropDownMenuState createState() => _BankListDropDownMenuState();
}

class _BankListDropDownMenuState extends State<BankListDropDownMenu> {
  late Future<BankList> bankList;
  String dropDownValue = 'Abbey Mortgage Bank';

  @override
  void initState() {
    super.initState();
    bankList = getListOfBanks();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BankList>(
      future: bankList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var listOfBanks = snapshot.data?.data.map((bank) => bank).toList();
            return DropdownButton<String>(
              value: dropDownValue,
              onChanged: (newValue) {
                setState(() {
                  dropDownValue = newValue!;
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
    );
  }
}
