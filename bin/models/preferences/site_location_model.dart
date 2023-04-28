class SiteLocalModel {
  late int? id;
  late String name; // Nom du site
  late String responsable;
  late String adresse;
  late String signature;
  late DateTime created;
  late DateTime updateCreated; 

  SiteLocalModel({
    this.id,
    required this.name,
    required this.responsable,
    required this.adresse,
    required this.signature,
    required this.created, 
    required this.updateCreated,
  });

  factory SiteLocalModel.fromSQL(List<dynamic> row) {
    return SiteLocalModel(
      id: row[0],
      name: row[1],
      responsable: row[2],
      adresse: row[3],
      signature: row[4],
      created: row[5],
      updateCreated: row[6],
    );
  }

  factory SiteLocalModel.fromJson(Map<String, dynamic> json) {
    return SiteLocalModel(
      id: json["id"],
      name: json["name"],
      responsable: json["responsable"],
      adresse: json["adresse"],
      signature: json["signature"],
      created: DateTime.parse(json['created']),
      updateCreated: DateTime.parse(json['updateCreated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'responsable': responsable,
      'adresse': adresse,
      'signature': signature,
      'created': created.toIso8601String(),
      'updateCreated': updateCreated.toIso8601String(),
    };
  }
}