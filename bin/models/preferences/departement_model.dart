// Titre d'emploie
class DepartementModel {
  late int? id;
  late String departement; // Entreprise
  late String signature;
  late DateTime created;
  late DateTime updateCreated; 

  DepartementModel({
    this.id,
    required this.departement,
    required this.signature,
    required this.created, 
    required this.updateCreated,
  });

  factory DepartementModel.fromSQL(List<dynamic> row) {
    return DepartementModel(
      id: row[0],
      departement: row[1],
      signature: row[2],
      created: row[3],
      updateCreated: row[4],
    );
  }

  factory DepartementModel.fromJson(Map<String, dynamic> json) {
    return DepartementModel(
      id: json["id"],
      departement: json["departement"], 
      signature: json["signature"],
      created: DateTime.parse(json['created']),
      updateCreated: DateTime.parse(json['updateCreated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'departement': departement,
      'signature': signature,
      'created': created.toIso8601String(),
      'updateCreated': updateCreated.toIso8601String(),
    };
  }
}
