class MonnaieModel {
  late int? id;
  late String monnaie;
  late String monnaieEnlettre;
  late String isActive;
  late String signature; // celui qui fait le document
  late DateTime created;
  late DateTime updateCreated;

  MonnaieModel({
    this.id,
    required this.monnaie,
    required this.monnaieEnlettre,
    required this.isActive,
    required this.signature,
    required this.created,
    required this.updateCreated,
  });

  factory MonnaieModel.fromSQL(List<dynamic> row) {
    return MonnaieModel(
      id: row[0],
      monnaie: row[1],
      monnaieEnlettre: row[2],
      isActive: row[3],
      signature: row[4],
      created: row[5],
      updateCreated: row[6],
    );
  }

  factory MonnaieModel.fromJson(Map<String, dynamic> json) {
    return MonnaieModel(
      id: json['id'],
      monnaie: json['monnaie'],
      monnaieEnlettre: json['monnaieEnlettre'],
      isActive: json['isActive'],
      signature: json['signature'],
      created: DateTime.parse(json['created']),
      updateCreated: DateTime.parse(json['updateCreated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'monnaie': monnaie,
      'monnaieEnlettre': monnaieEnlettre,
      'isActive': isActive,
      'signature': signature,
      'created': created.toIso8601String(),
      'updateCreated': updateCreated.toIso8601String(),
    };
  }
}
