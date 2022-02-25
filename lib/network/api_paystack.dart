import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/BankList.dart';

Future<BankList> getListOfBanks() async {
  const String bankListUrl = 'https://api.paystack.co/bank';
  final response = await http.get(Uri.parse(bankListUrl));
  if (response.statusCode == 200) {
    return BankList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Error - no data from api');
  }
}
