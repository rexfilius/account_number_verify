import 'package:flutter/material.dart';
import 'package:account_number_verify/app_library.dart';

class BankListBuilder extends StatefulWidget {
  BankListBuilder({
    required this.buttonSelection,
    required this.bankList,
    required this.bankCode,
    required this.retrieveBankCode,
    Key? key,
  }) : super(key: key);

  String buttonSelection;
  String? bankCode;
  Future<BankList> bankList;
  String? Function(List<Data> dataList, String name) retrieveBankCode;

  @override
  State<BankListBuilder> createState() => _BankListBuilderState();
}

class _BankListBuilderState extends State<BankListBuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BankList>(
      future: widget.bankList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var listOfBanks =
            snapshot.data?.data.map((bank) => bank).toList();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButton<String>(
                isExpanded: true,
                elevation: 12,
                value: widget.buttonSelection,
                onChanged: (newValue) {
                  setState(() {
                    widget.buttonSelection = newValue!;
                    widget.bankCode = widget.retrieveBankCode as String?;
                  });
                },
                items: listOfBanks?.map((bank) {
                  return DropdownMenuItem<String>(
                    value: bank.name,
                    child: Text(bank.name!),
                  );
                }).toList(),
              ),
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
