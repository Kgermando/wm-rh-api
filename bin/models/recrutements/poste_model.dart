
// Poste à promouvoir et en attente des candidatures 
class PosteModel {
  late int? id; 
  late String statut; // Disponible True or false
  late String searchProfil; // Description du profil rechercher
  late String sexe; // Homme, Femme, les deux
  late String salaire; // Facultatif
  late String typeContrat;
  late String signature;
  late DateTime created;
  late DateTime updateCreated;

  PosteModel({
    this.id,
    required this.statut,
    required this.searchProfil,
    required this.sexe,
    required this.salaire,
    required this.typeContrat,
    required this.signature,
    required this.created,
    required this.updateCreated,
  }); 


  factory PosteModel.fromSQL(List<dynamic> row) {
    return PosteModel(
      id: row[0],
      statut: row[1],
      searchProfil: row[2],
      sexe: row[3],
      salaire: row[4],
      typeContrat: row[5],
      signature: row[6],
      created: row[7],
      updateCreated: row[8],
    );
  }

  factory PosteModel.fromJson(Map<String, dynamic> json) {
    return PosteModel(
      id: json['id'],
      statut: json['statut'], 
      searchProfil: json['searchProfil'],
      sexe: json['sexe'],
      salaire: json['salaire'],
      typeContrat: json['typeContrat'],
      signature: json['signature'],
      created: DateTime.parse(json['created']),
      updateCreated: DateTime.parse(json['updateCreated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'statut': statut,
      'searchProfil': searchProfil,
      'sexe': sexe,
      'salaire': salaire,
      'typeContrat': typeContrat,
      'signature': signature,
      'created': created.toIso8601String(),
      'updateCreated': updateCreated.toIso8601String(),
    };
  }
}