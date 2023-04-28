class UserModel {
  late int? id;
  late String photo;
  late String nom;
  late String postnom;
  late String prenom;
  late String email;
  late String telephone;
  late String adresse;
  late String sexe;
  late String nationalite;
  late String etatCivile;

  late String matricule;
  late String numeroCNSS;
  late String role; // Acces user de 1 à 5

  late String departement;
  late String title;  // Ex: Directeur 
  late String fonction; // Ex: 
  late String services; // RH
  late String siteLocation; // Site de travail

  late String signature; // celui qui fait le document
  late DateTime created;
  late DateTime updateCreated;
  late String passwordHash; 

  UserModel({
    this.id,
    required this.photo,
    required this.nom,
    required this.postnom,
    required this.prenom,
    required this.email,
    required this.telephone,
    required this.adresse,
    required this.sexe,
    required this.nationalite,
    required this.etatCivile,

    required this.matricule,
    required this.numeroCNSS,
    required this.role,

    required this.departement, 
    required this.title,
    required this.fonction, 
    required this.services,
    required this.siteLocation, // SUccursale 

    required this.signature,
    required this.created,
    required this.updateCreated,
    required this.passwordHash,

  });

  factory UserModel.fromSQL(List<dynamic> row) {
    return UserModel(
      id: row[0],
      photo: row[1],
      nom: row[2],
      postnom: row[3],
      prenom: row[4],
      email: row[5],
      telephone: row[6],
      adresse: row[7],
      sexe: row[8],
      nationalite: row[9],
      etatCivile: row[10],
      matricule: row[11],
      numeroCNSS: row[12],
      role: row[13],
      departement: row[14],
      title: row[15], 
      fonction: row[16],
      services: row[17],
      siteLocation: row[18], 
      signature: row[19],
      created: row[20],
      updateCreated: row[21],
      passwordHash: row[22],
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      photo: json["photo"],
      nom: json["nom"],
      postnom: json["postnom"],
      prenom: json["prenom"],
      email: json["email"],
      telephone: json["telephone"],
      adresse: json["adresse"],
      sexe: json["sexe"],
      nationalite: json["nationalite"], 
      etatCivile: json["etatCivile"],
      matricule: json["matricule"],
      numeroCNSS: json["numeroCNSS"],
      role: json["role"],
      departement: json["departement"],
      title: json["title"],
      fonction: json["fonction"],
      services: json["services"],
      siteLocation: json["siteLocation"],
      signature: json['signature'],
      created: DateTime.parse(json['created']),
      updateCreated: DateTime.parse(json['updateCreated']),
      passwordHash: json['passwordHash'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photo': photo,
      'nom': nom,
      'postnom': postnom,
      'prenom': prenom,
      'email': email,
      'telephone': telephone,
      'adresse': adresse,
      'sexe': sexe,
      'nationalite': nationalite,
      'etatCivile': etatCivile,
      'matricule': matricule,
      'numeroCNSS': numeroCNSS,
      'role': role,
      'departement': departement,
      'title': title,
      'fonction': fonction,
      'services': services,
      'siteLocation': siteLocation,
      'signature': signature,
      'created': created.toIso8601String(),
      'updateCreated': updateCreated.toIso8601String(),
      'passwordHash': passwordHash,
    };
  }
}
