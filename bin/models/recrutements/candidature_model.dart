// les candidature valider on va les remplir dans les personnels
class CandidatureModel {
  late int? id;
  late int reference; // Poste
  late String scanUrl;
  late String fullName;
  late String sexe;
  late String departement;
  late String statut; // Valider True or False
  late String signature;
  late DateTime created;
  late String business;
  late DateTime updateCreated;

  CandidatureModel({
    this.id,
    required this.reference,
    required this.scanUrl,
    required this.fullName,
    required this.sexe,
    required this.departement,
    required this.statut,
    required this.signature,
    required this.created,
    required this.updateCreated,
  }); 


  factory CandidatureModel.fromSQL(List<dynamic> row) {
    return CandidatureModel(
      id: row[0],
      reference: row[1],
      scanUrl: row[2],
      fullName: row[3],
      sexe: row[4],
      departement: row[5],
      statut: row[6],
      signature: row[7],
      created: row[8],
      updateCreated: row[9], 
    );
  }

  factory CandidatureModel.fromJson(Map<String, dynamic> json) {
    return CandidatureModel(
      id: json['id'],
      reference: json['reference'], 
      scanUrl: json['scanUrl'],
      fullName: json['fullName'],
      sexe: json['sexe'],
      departement: json['departement'],
      statut: json['statut'],
      signature: json['signature'],
      created: DateTime.parse(json['created']),
      updateCreated: DateTime.parse(json['updateCreated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference': reference,
      'scanUrl': scanUrl,
      'fullName': fullName,
      'sexe': sexe,
      'departement': departement,
      'statut': statut,
      'signature': signature,
      'created': created.toIso8601String(),
      'updateCreated': updateCreated.toIso8601String(),
    };
  }

}