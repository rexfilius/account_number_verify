import 'package:account_number_verify/screens/paystack_screen/providers/paystack_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:account_number_verify/app_library.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PayStackScreen extends ConsumerStatefulWidget {
  const PayStackScreen({Key? key}) : super(key: key);

  @override
  _PayStackScreenState createState() => _PayStackScreenState();
}

class _PayStackScreenState extends ConsumerState {
  late Future<BankList> bankList;
  Future<GetAccountNumber>? accountNumber;
  final TextEditingController _controller = TextEditingController();

  String dropDownValue = 'Abbey Mortgage Bank';
  String? bankItemCode;

  @override
  void initState() {
    super.initState();
    bankList = getListOfBanks();
  }

  String? _getBankCode(List<Data> dataList, String name) {
    var bank = dataList.where((bankObject) {
      return bankObject.name == name;
    }).toList();

    for (var element in bank) {
      return element.code;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<BankList> bankList = ref.watch(bankListProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        bankList.when(
          data: (bankList) {
            return Text('');
          },
          error: (error, stack) {
            return Text('$error');
          },
          loading: () => const CircularProgressIndicator(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Your Account Number?',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              accountNumber = getAccountNumber(
                accountNumber: _controller.text,
                bankCode: bankItemCode ?? '000', // bankItemCode ?? '000'
              );
              print('dropDownValue = $dropDownValue');
              print('bank item code = $bankItemCode');
            });
          },
          child: const Text('Confirm Number'),
        ),
        // (50211-KudaBank-2009943490) (058-GTB-0567482425)
        AccountNumberBuilder(accountNumber: accountNumber),
      ],
    );
  }
}

// FutureBuilder<BankList>(
//           future: bankList,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               if (snapshot.hasData) {
//                 var listOfBanks =
//                     snapshot.data?.data.map((bank) => bank).toList();
//                 return Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: DropdownButton<String>(
//                     isExpanded: true,
//                     elevation: 12,
//                     value: dropDownValue,
//                     onChanged: (newValue) {
//                       setState(() {
//                         dropDownValue = newValue!;
//                         bankItemCode =
//                             _getBankCode(listOfBanks!, dropDownValue);
//                       });
//                     },
//                     items: listOfBanks?.map((bank) {
//                       return DropdownMenuItem<String>(
//                         value: bank.name,
//                         child: Text(bank.name!),
//                       );
//                     }).toList(),
//                   ),
//                 );
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('${snapshot.error}'));
//               }
//             }
//             return const Center(child: CircularProgressIndicator());
//           },
//         ),
