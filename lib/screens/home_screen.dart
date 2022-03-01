import 'package:flutter/material.dart';
import 'package:account_number_verify/app_library.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PayStack API'),
      ),
      body: const PayStackScreen(),
    );
  }
}
