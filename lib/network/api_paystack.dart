import 'dart:convert';

import 'package:account_number_verify/model/get_account_number.dart';
import 'package:http/http.dart' as http;

import '../keys/keys.dart';
import '../model/bank_list.dart';

const baseUrl = 'https://api.paystack.co/bank';

Future<BankList> getListOfBanks() async {
  final response = await http.get(Uri.parse(baseUrl));
  if (response.statusCode == 200) {
    return BankList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Error - no data from api');
  }
}

Future<GetAccountNumber> getAccountNumber({
  required int accountNumber,
  required int bankCode,
}) async {
  String bankListUrl =
      '$baseUrl/resolve?account_number=$accountNumber&bank_code=$bankCode';
  final response = await http.get(
    Uri.parse(bankListUrl),
    headers: {'Authorization': 'Bearer $payStackKey'},
  );

  if (response.statusCode == 200) {
    return GetAccountNumber.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
}

