import 'package:account_number_verify/app_library.dart';

class BankList {
  bool? status;
  String? message;
  List<Data> data;

  BankList({
    this.status,
    this.message,
    required this.data,
  });

  factory BankList.fromJson(Map<String, dynamic> json) {
    return BankList(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['data'] = data.map((v) => v.toJson()).toList();
    return map;
  }
}
