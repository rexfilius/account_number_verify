import 'package:account_number_verify/widgets/bank_list_drop_down.dart';
import 'package:account_number_verify/widgets/confirm_account_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PayStack API'),
      ),
      body: Column(
        children: const [
          BankListDropDownMenu(),
          ConfirmAccountWidget(),
        ],
      ),
    );
  }
}
