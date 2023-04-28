class PreferenceModel {
  late int? id;

  // Infos entreprise 
  late String companyName;
  late String nbrEmploye;
  late String cnss;
  late String numeroTaxe;
  late String rccm;
  late String idNat;
  late String numeroImpot;
  late String email;
  late String telephone;
  late String adresse;
  
  // Date de paie
  late DateTime dateDePaie;

  // Impot societe
  late String cnssQPP;
  late String inpp;
  late String onem;
 
  // Parametre de deduction
  late String cotisationSyndicale;
  late String cnssQPO;

  // Autres beneficiaires
  late String allocationLogement;
  late String allocationTransport; 
  late String nbrMaxEnfantCourvert;
  late String allocationFamilliale;
  late String allocationEpouse;

  // Taux
  late String nbreHeureTravail;
  late String tauxDollard;

  // Jours feries
  late DateTime newYear;
  late DateTime noel;
  late DateTime martyrDay;
  late DateTime kabilaDay;
  late DateTime lumumbaDay;
  late DateTime labourDay;
  late DateTime liberationDay;
  late DateTime indepenceDay;
  late DateTime parentDay;
  late DateTime kimbanguDay;
 
  late String signature;
  late DateTime created;
  late DateTime updateCreated; 

  PreferenceModel({
    this.id,
    required this.companyName,
    required this.nbrEmploye,
    required this.cnss,
    required this.numeroTaxe,
    required this.rccm,
    required this.idNat,
    required this.numeroImpot,
    required this.email,
    required this.telephone,
    required this.adresse,

    // Date de paie
    required this.dateDePaie,

    // Impot societe
    required this.cnssQPP,
    required this.inpp,
    required this.onem,

    // Parametre de deduction
    required this.cotisationSyndicale,
    required this.cnssQPO,

    // Autres beneficiaires
    required this.allocationLogement,
    required this.allocationTransport, 
    required this.nbrMaxEnfantCourvert,
    required this.allocationFamilliale,
    required this.allocationEpouse,

    // Taux journaliers
    required this.nbreHeureTravail,
    required this.tauxDollard,

    // Jours feries
    required this.newYear,
    required this.noel,
    required this.martyrDay,
    required this.kabilaDay,
    required this.lumumbaDay,
    required this.labourDay,
    required this.liberationDay,
    required this.indepenceDay,
    required this.parentDay,
    required this.kimbanguDay,
    required this.signature,
    required this.created, 
    required this.updateCreated,
  });


 factory PreferenceModel.fromSQL(List<dynamic> row) {
    return PreferenceModel(
      id: row[0],
      companyName: row[1],
      nbrEmploye: row[2],
      cnss: row[3],
      numeroTaxe: row[4],
      rccm: row[5],
      idNat: row[6],
      numeroImpot: row[7],
      email: row[8],
      telephone: row[9],
      adresse: row[10], 

      dateDePaie: row[11],
      cnssQPP: row[12],
      inpp: row[13],
      onem: row[14],

      cotisationSyndicale: row[15],
      cnssQPO: row[16],

      allocationLogement: row[17],
      allocationTransport: row[18],
      nbrMaxEnfantCourvert: row[19],
      allocationFamilliale: row[20],
      allocationEpouse: row[21],

      nbreHeureTravail: row[22],
      tauxDollard: row[23],

      newYear: row[24],
      noel: row[25],
      martyrDay: row[26],
      kabilaDay: row[27],
      lumumbaDay: row[28],
      labourDay: row[29],
      liberationDay: row[30], 
      indepenceDay: row[31],
      parentDay: row[32],
      kimbanguDay: row[33],

      signature: row[34],
      created: row[35],
      updateCreated: row[36],
    );
  }

  factory PreferenceModel.fromJson(Map<String, dynamic> json) {
    return PreferenceModel(
      id: json["id"],

      companyName: json["companyName"],
      nbrEmploye: json["nbrEmploye"],
      cnss: json["cnss"],
      numeroTaxe: json["numeroTaxe"],
      rccm: json["rccm"],
      idNat: json["idNat"],
      numeroImpot: json["numeroImpot"],
      email: json["email"],
      telephone: json["telephone"],
      adresse: json["adresse"],

      dateDePaie: json["dateDePaie"],

      cnssQPP: json["cnssQPP"],
      inpp: json["inpp"],
      onem: json["onem"],

      cotisationSyndicale: json["cotisationSyndicale"],
      cnssQPO: json["cnssQPO"],

      allocationLogement: json["allocationLogement"],
      allocationTransport: json["allocationTransport"],
      nbrMaxEnfantCourvert: json["nbrMaxEnfantCourvert"],
      allocationFamilliale: json["allocationFamilliale"],
      allocationEpouse: json["allocationEpouse"],

      nbreHeureTravail: json["nbreHeureTravail"],
      tauxDollard: json["tauxDollard"],

      newYear: json["newYear"],
      noel: json["noel"],

      martyrDay: DateTime.parse(json['martyrDay']),
      kabilaDay: DateTime.parse(json['kabilaDay']),
      lumumbaDay: DateTime.parse(json['lumumbaDay']),
      labourDay: DateTime.parse(json['labourDay']),
      liberationDay: DateTime.parse(json['liberationDay']),
      indepenceDay: DateTime.parse(json['indepenceDay']),
      parentDay: DateTime.parse(json['parentDay']),
      kimbanguDay: DateTime.parse(json['kimbanguDay']),

      signature: json["signature"],
      created: DateTime.parse(json['created']),
      updateCreated: DateTime.parse(json['updateCreated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,

      'companyName': companyName,
      'nbrEmploye': nbrEmploye,
      'cnss': cnss,
      'numeroTaxe': numeroTaxe,
      'rccm': rccm,
      'idNat': idNat,
      'numeroImpot': numeroImpot,
      'email': email,
      'telephone': telephone,
      'adresse': adresse,

      'dateDePaie': dateDePaie,

      'cnssQPP': cnssQPP,
      'inpp': inpp,
      'onem': onem,

      'cotisationSyndicale': cotisationSyndicale,
      'cnssQPO': cnssQPO,

      'allocationLogement': allocationLogement,
      'allocationTransport': allocationTransport,
      'nbrMaxEnfantCourvert': nbrMaxEnfantCourvert,
      'allocationFamilliale': allocationFamilliale,
      'allocationEpouse': allocationEpouse,

      'nbreHeureTravail': nbreHeureTravail,
      'tauxDollard': tauxDollard,

      'newYear': newYear.toIso8601String(),
      'noel': noel.toIso8601String(),
      'martyrDay': martyrDay.toIso8601String(),
      'kabilaDay': kabilaDay.toIso8601String(),
      'lumumbaDay': lumumbaDay.toIso8601String(),
      'labourDay': labourDay.toIso8601String(),
      'liberationDay': liberationDay.toIso8601String(),
      'indepenceDay': indepenceDay.toIso8601String(),
      'parentDay': parentDay.toIso8601String(),
      'kimbanguDay': kimbanguDay.toIso8601String(),

      'signature': signature,
      'created': created.toIso8601String(),
      'updateCreated': updateCreated.toIso8601String(),
    };
  }
  
}


