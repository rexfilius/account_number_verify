class GetAccountNumber {
  GetAccountNumber({
    this.status,
    this.message,
    required this.data,
  });

  bool? status;
  String? message;
  Data data;

  factory GetAccountNumber.fromJson(Map<String, dynamic> json) {
    return GetAccountNumber(
      status: json["status"],
      message: json["message"],
      data: Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "data": data.toJson(),
    };
  }
}

class Data {
  Data({
    required this.accountNumber,
    required this.accountName,
    this.bankId,
  });

  String accountNumber;
  String accountName;
  int? bankId;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      accountNumber: json["account_number"],
      accountName: json["account_name"],
      bankId: json["bank_id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "account_number": accountNumber,
      "account_name": accountName,
      "bank_id": bankId,
    };
  }
}
