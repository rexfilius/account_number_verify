class Data {
  String? name;
  String? slug;
  String? code;
  String? longcode;
  Object? gateway;
  bool? payWithBank;
  bool? active;
  bool? isDeleted;
  String? country;
  String? currency;
  String? type;
  int? id;
  String? createdAt;
  String? updatedAt;

  Data({
    this.name,
    this.slug,
    this.code,
    this.longcode,
    this.gateway,
    this.payWithBank,
    this.active,
    this.isDeleted,
    this.country,
    this.currency,
    this.type,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      name: json['name'],
      slug: json['slug'],
      code: json['code'],
      longcode: json['longcode'],
      gateway: json['gateway'],
      payWithBank: json['pay_with_bank'],
      active: json['active'],
      isDeleted: json['is_deleted'],
      country: json['country'],
      currency: json['currency'],
      type: json['type'],
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['slug'] = slug;
    map['code'] = code;
    map['longcode'] = longcode;
    map['gateway'] = gateway;
    map['pay_with_bank'] = payWithBank;
    map['active'] = active;
    map['is_deleted'] = isDeleted;
    map['country'] = country;
    map['currency'] = currency;
    map['type'] = type;
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }
}
