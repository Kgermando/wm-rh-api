class PerformenceModel {
  late int? id;
  late String matricule;
  late String departement;
  late String nom;
  late String postnom;
  late String prenom;
  late String signature; // celui qui fait le document
  late DateTime created;
  late DateTime updateCreated;

  PerformenceModel({
    this.id,
    required this.matricule,
    required this.departement,
    required this.nom,
    required this.postnom,
    required this.prenom,
    required this.signature,
    required this.created,
    required this.updateCreated,
  });

  factory PerformenceModel.fromSQL(List<dynamic> row) {
    return PerformenceModel(
      id: row[0],
      matricule: row[1],
      departement: row[2],
      nom: row[3],
      postnom: row[4],
      prenom: row[5],
      signature: row[6],
      created: row[7],
      updateCreated: row[8],
    );
  }

  factory PerformenceModel.fromJson(Map<String, dynamic> json) {
    return PerformenceModel(
      id: json['id'],
      matricule: json['matricule'],
      departement: json['departement'],
      nom: json['nom'],
      postnom: json['postnom'],
      prenom: json['prenom'],
      signature: json['signature'],
      created: DateTime.parse(json['created']),
      updateCreated: DateTime.parse(json['updateCreated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'matricule': matricule,
      'departement': departement,
      'nom': nom,
      'postnom': postnom,
      'prenom': prenom,
      'signature': signature,
      'created': created.toIso8601String(),
      'updateCreated': updateCreated.toIso8601String(),
    };
  }
}

class PerformenceNoteModel {
  late int? id;
  late int reference;
  late String matricule;
  late String departement;
  late String hospitalite;
  late String ponctualite;
  late String travaille;
  late String note;
  late String signature;
  late DateTime created;
  late DateTime updateCreated;

  PerformenceNoteModel({
    this.id,
    required this.reference,
    required this.matricule,
    required this.departement,
    required this.hospitalite,
    required this.ponctualite,
    required this.travaille,
    required this.note,
    required this.signature,
    required this.created,
    required this.updateCreated,
  });

  factory PerformenceNoteModel.fromSQL(List<dynamic> row) {
    return PerformenceNoteModel(
      id: row[0],
      reference: row[1],
      matricule: row[2],
      departement: row[3],
      hospitalite: row[4],
      ponctualite: row[5],
      travaille: row[6],
      note: row[7],
      signature: row[8],
      created: row[9],
      updateCreated: row[10],
    );
  }

  factory PerformenceNoteModel.fromJson(Map<String, dynamic> json) {
    return PerformenceNoteModel(
      id: json['id'],
      reference: json['reference'],
      matricule: json['matricule'],
      departement: json['departement'],
      hospitalite: json['hospitalite'],
      ponctualite: json['ponctualite'],
      travaille: json['travaille'],
      note: json['note'],
      signature: json['signature'],
      created: DateTime.parse(json['created']),
      updateCreated: DateTime.parse(json['updateCreated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference': reference,
      'matricule': matricule,
      'departement': departement,
      'hospitalite': hospitalite,
      'ponctualite': ponctualite,
      'travaille': travaille,
      'note': note,
      'signature': signature,
      'created': created.toIso8601String(),
      'updateCreated': updateCreated.toIso8601String(),
    };
  }
}
