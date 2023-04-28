class PersonnelModel {
  late int? id;
  // Identite
  late String photo;
  late String nom;
  late String postnom;
  late String prenom;
  late String email;
  late String telephone;
  late String adresse;
  late String sexe;
  late DateTime dateNaissance;
  late String lieuNaissance;
  late String nationalite;
  late String etatCivile;
  late String nbrEnfant;
  late String nbrDependants;
  late String nbrDependantsMax;

  // Accès
  late String matricule;
  late String numeroCNSS;
  late String role; // droit d'acces au logiciel de 0 à 5

  // Travail
  late String departement;
  late String title;  // Ex: Directeur 
  late String fonction; // Ex: 
  late String services; // RH
  late String siteLocation; // Site de travail

  // Contrat
  late String typeContrat;
  late DateTime dateDebutContrat;
  late DateTime dateFinContrat; 
 
  // Salaire
  late String salaire; //   Salaire de Base
  late String compteBancaire;
  late String nomBanque;
  late String fraisBancaire; // Frais de compte

  // Profil
  late String statutPersonnel;
  late String cvUrl; // CV scan 
  late String signature; // celui qui fait le document
  late DateTime created;
  late DateTime updateCreated;
  late String isDelete;

  PersonnelModel({
    this.id,
    required this.photo,
    required this.nom,
    required this.postnom,
    required this.prenom,
    required this.email,
    required this.telephone,
    required this.adresse,
    required this.sexe,
    required this.dateNaissance,
    required this.lieuNaissance,
    required this.nationalite,
    required this.etatCivile,
    required this.nbrEnfant,
    required this.nbrDependants,
    required this.nbrDependantsMax,

    required this.matricule,
    required this.numeroCNSS,
    required this.role,

    required this.departement, 
    required this.title,
    required this.fonction, 
    required this.services,
    required this.siteLocation,

    required this.typeContrat,
    required this.dateDebutContrat,
    required this.dateFinContrat,

    required this.salaire, 
    required this.compteBancaire,
    required this.nomBanque,
    required this.fraisBancaire,
    
    required this.statutPersonnel,
    required this.cvUrl, 
    required this.signature,
    required this.created,
    required this.updateCreated,
    required this.isDelete,
  });

  factory PersonnelModel.fromSQL(List<dynamic> row) {
    return PersonnelModel(
        id: row[0],
        photo: row[1],
        nom: row[2],
        postnom: row[3],
        prenom: row[4],
        email: row[5],
        telephone: row[6],
        adresse: row[7],
        sexe: row[8],
        dateNaissance: row[9],
        lieuNaissance: row[10],
        nationalite: row[11],
        etatCivile: row[12],
        nbrEnfant: row[13],
        nbrDependants: row[14],
        nbrDependantsMax: row[15],

        matricule: row[16],
        numeroCNSS: row[17],
        role: row[18],

        departement: row[19],
        title: row[20], 
        fonction: row[21],
        services: row[22],
        siteLocation: row[23],

        typeContrat: row[24],
        dateDebutContrat: row[25], 
        dateFinContrat: row[26],

        salaire: row[27], 
        compteBancaire: row[28],
        nomBanque: row[29],
        fraisBancaire: row[30],

        statutPersonnel: row[31], 
        cvUrl: row[32],
        signature: row[33],
        created: row[34],
        updateCreated: row[35],
        isDelete: row[36],
    );
  }

  factory PersonnelModel.fromJson(Map<String, dynamic> json) {
    return PersonnelModel(
      id: json["id"],
      photo: json["photo"],
      nom: json["nom"],
      postnom: json["postnom"],
      prenom: json["prenom"],
      email: json["email"],
      telephone: json["telephone"],
      adresse: json["adresse"],
      sexe: json["sexe"],
      dateNaissance: DateTime.parse(json['dateNaissance']),
      lieuNaissance: json["lieuNaissance"],
      nationalite: json["nationalite"], 
      etatCivile: json["etatCivile"],
      nbrEnfant: json["nbrEnfant"],
      nbrDependants: json["nbrDependants"],
      nbrDependantsMax: json["nbrDependantsMax"],

      matricule: json["matricule"],
      numeroCNSS: json["numeroCNSS"],
      role: json["role"],

      departement: json["departement"],
      title: json["title"],
      fonction: json["fonction"],
      services: json["services"],
      siteLocation: json["siteLocation"],

      typeContrat: json["typeContrat"],
      dateDebutContrat: DateTime.parse(json['dateDebutContrat']),
      dateFinContrat: DateTime.parse(json['dateFinContrat']),
      
      salaire: json['salaire'],
      compteBancaire: json['compteBancaire'],
      nomBanque: json['nomBanque'],
      fraisBancaire: json['fraisBancaire'],
      
      statutPersonnel: json["statutPersonnel"],
      cvUrl: json["cvUrl"],
      signature: json['signature'],
      created: DateTime.parse(json['created']),
      updateCreated: DateTime.parse(json['updateCreated']),
      isDelete: json['isDelete'],
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
      'dateNaissance': dateNaissance.toIso8601String(),
      'lieuNaissance': lieuNaissance,
      'nationalite': nationalite,
      'etatCivile': etatCivile,
      'nbrEnfant': nbrEnfant,
      'nbrDependants': nbrDependants,
      'nbrDependantsMax': nbrDependantsMax,
      
      'matricule': matricule,
      'numeroCNSS': numeroCNSS,
      'role': role,

      'departement': departement,
      'title': title,
      'fonction': fonction,
      'services': services,
      'siteLocation': siteLocation,

      'typeContrat': typeContrat,
      'dateDebutContrat': dateDebutContrat.toIso8601String(),
      'dateFinContrat': dateFinContrat.toIso8601String(),
      
      'salaire': salaire,
      'compteBancaire': compteBancaire,
      'nomBanque': nomBanque,
      'fraisBancaire': fraisBancaire,

      'statutPersonnel': statutPersonnel,
      'cvUrl': cvUrl,
      'signature': signature,
      'created': created.toIso8601String(),
      'updateCreated': updateCreated.toIso8601String(),
      'isDelete': isDelete,
    };
  }
}