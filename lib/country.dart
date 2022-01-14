class Country {
  final String name;
  final String flag;
  final String code;
  final String nametag;

  Country(this.name, this.flag, this.code, this.nametag);

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(json['name']['common'] ?? '', json['flag'] ?? '',
        json['idd']['root'] ?? '', json['cca2'] ?? '');
  }
}
