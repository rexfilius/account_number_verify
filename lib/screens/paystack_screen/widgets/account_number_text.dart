import 'package:flutter/material.dart';

class AccountNumberText extends StatelessWidget {
  const AccountNumberText({
    required this.bankAccountName,
    required this.bankAccountNumber,
    Key? key,
  }) : super(key: key);

  final String bankAccountName;
  final String bankAccountNumber;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Bank Account Name'),
            Text(bankAccountName),
            const SizedBox(height: 12.0),
            const Text('Bank Account Number'),
            Text(bankAccountNumber),
          ],
        ),
      ),
    );
  }
}
