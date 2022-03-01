import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:account_number_verify/app_library.dart';

/// Base Url for the PayStack api
const baseUrl = 'https://api.paystack.co/bank';

Future<BankList> getListOfBanks() async {
  final response = await http.get(
    Uri.parse("$baseUrl?currency=NGN"),
    headers: {'Authorization': 'Bearer $payStackKey'},
  );

  if (response.statusCode == 200) {
    return BankList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Error - no data from api');
  }
}

Future<GetAccountNumber> getAccountNumber({
  required String accountNumber,
  required String bankCode,
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
