class PenaliteModel {
  late int? id;
  late int reference;
  late String type;
  late String montant;  
  late String motif;
  late String signature;
  late DateTime created; 
  late DateTime updateCreated;  

  PenaliteModel({
    this.id,
    required this.reference,
    required this.type,
    required this.montant,
    required this.motif,
    required this.signature,
    required this.created,
    required this.updateCreated,
  });

  factory PenaliteModel.fromSQL(List<dynamic> row) {
    return PenaliteModel(
      id: row[0],
      reference: row[1],
      type: row[2],
      montant: row[3],
      motif: row[4],
      signature: row[5],
      created: row[6], 
      updateCreated: row[7],
    );
  }

  factory PenaliteModel.fromJson(Map<String, dynamic> json) {
    return PenaliteModel(
      id: json["id"],
      reference: json["reference"],
      type: json["type"],
      montant: json["montant"],
      motif: json["motif"],
      signature: json["signature"],
      created: DateTime.parse(json['created']),
      updateCreated: DateTime.parse(json['updateCreated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference': reference,
      'type': type,
      'montant': montant,
      'motif': motif,
      'signature': signature,
      'created': created.toIso8601String(), 
      'updateCreated': updateCreated.toIso8601String(),
    };
  }
}