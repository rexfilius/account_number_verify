import 'package:flutter/material.dart';
import 'package:account_number_verify/app_library.dart';

class AccountNumberBuilder extends StatelessWidget {
  const AccountNumberBuilder({
    required this.accountNumber,
    Key? key,
  }) : super(key: key);

  final Future<GetAccountNumber>? accountNumber;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GetAccountNumber>(
      future: accountNumber,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final number = snapshot.data?.data.accountNumber;
            final name = snapshot.data?.data.accountName;
            return AccountNumberText(
              bankAccountName: name ?? 'No name',
              bankAccountNumber: number ?? 'No number',
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
        }
        return const Center();
      },
    );
  }
}
