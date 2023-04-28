// Il permet d'ajouter une date de presence ou absence chaque jour
class ApointementModel {
  late int? id;
  late int reference; // ReleveEmployeModel
  late String refDate; // La date du jour pour filter
  late String matricule;
  late String apointement; // Type de presence Ex: Present , Absent,....

  late String signature;
  late DateTime created;
  late DateTime updateCreated;

  ApointementModel({
    this.id,
    required this.reference,
    required this.refDate,
    required this.matricule,
    required this.apointement,
    required this.signature,
    required this.created,
    required this.updateCreated,
  });

  factory ApointementModel.fromSQL(List<dynamic> row) {
    return ApointementModel(
      id: row[0],
      reference: row[1],
      refDate: row[2],
      matricule: row[3],
      apointement: row[4],
      signature: row[5],
      created: row[6], 
      updateCreated: row[7],
    );
  }

  factory ApointementModel.fromJson(Map<String, dynamic> json) {
    return ApointementModel(
      id: json['id'],
      reference: json['reference'],
      refDate: json['refDate'],
      matricule: json['matricule'],
      apointement: json['apointement'],
      signature: json['signature'],
      created: DateTime.parse(json['created']),
      updateCreated: DateTime.parse(json['updateCreated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference': reference,
      'refDate': refDate,
      'matricule': matricule,
      'apointement': apointement,
      'signature': signature,
      'created': created.toIso8601String(),
      'updateCreated': updateCreated.toIso8601String(),
    };
  }
}

// Pour éviter surcharge il faut mettre un filter Date(Mois et AN) directement au niveau du backend


// Comment faire ajouter les dates d'une plage dans appontement