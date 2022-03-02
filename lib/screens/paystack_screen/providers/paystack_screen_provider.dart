import 'package:account_number_verify/app_library.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bankListProvider = FutureProvider<BankList>((ref) async {
  return getListOfBanks();
});

FutureProvider<GetAccountNumber> accountNumberProviderFunc(
    String accountNumber, String bankCode,) {
  return FutureProvider<GetAccountNumber>((ref) async {
    return getAccountNumber(
      accountNumber: accountNumber,
      bankCode: bankCode,
    );
  });
}

