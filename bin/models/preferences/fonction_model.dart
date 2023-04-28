// Titre d'emploie
class FonctionModel {
  late int? id;
  late String title; // Ex: Directeur
  late String fonction; // Ex:
  late String services; // RH
  late String signature;
  late DateTime created;
  late DateTime updateCreated; 

  FonctionModel({
    this.id,
    required this.title,
    required this.fonction,
    required this.services,
    required this.signature,
    required this.created, 
    required this.updateCreated,
  });

  factory FonctionModel.fromSQL(List<dynamic> row) {
    return FonctionModel(
      id: row[0],
      title: row[1],
      fonction: row[2],
      services: row[3],
      signature: row[4],
      created: row[5], 
      updateCreated: row[6],
    );
  }

  factory FonctionModel.fromJson(Map<String, dynamic> json) {
    return FonctionModel(
      id: json["id"],
      title: json["title"],
      fonction: json["fonction"],
      services: json["services"], 
      signature: json["signature"],
      created: DateTime.parse(json['created']),
      updateCreated: DateTime.parse(json['updateCreated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'fonction': fonction,
      'services': services, 
      'signature': signature,
      'created': created.toIso8601String(),
      'updateCreated': updateCreated.toIso8601String(),
    };
  }
}
