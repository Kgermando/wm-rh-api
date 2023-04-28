class AvanceSalaire {
  late int? id;
  late int reference;
  late String nom;
  late String postNom;
  late String prenom;
  late String avance;  // Montant avance
  late String observation; // Avance du Salaire
  late String commentaire; 
  late String signature;
  late DateTime created;
  late DateTime updateCreated;

  
  AvanceSalaire({
    this.id,
    required this.reference,
    required this.nom,
    required this.postNom,
    required this.prenom,
    required this.avance,
    required this.observation,
    required this.commentaire,
    required this.signature,
    required this.created,
    required this.updateCreated,
  });

  factory AvanceSalaire.fromSQL(List<dynamic> row) {
    return AvanceSalaire(
      id: row[0],
      reference: row[1],
      nom: row[2],
      postNom: row[3],
      prenom: row[4],
      avance: row[5],
      observation: row[6],
      commentaire: row[7],
      signature: row[8],
      created: row[9], 
      updateCreated: row[4],
    );
  }

  factory AvanceSalaire.fromJson(Map<String, dynamic> json) {
    return AvanceSalaire(
      id: json["id"],
      reference: json["reference"],
      nom: json["nom"],
      postNom: json["postNom"],
      prenom: json["prenom"],
      avance: json["avance"],
      observation: json["observation"],
      commentaire: json["commentaire"],
      signature: json["signature"],
      created: DateTime.parse(json['created']),
      updateCreated: DateTime.parse(json['updateCreated']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reference': reference,
      'nom': nom,
      'postNom': postNom,
      'prenom': prenom,
      'avance': avance,
      'observation': observation,
      'commentaire': commentaire,
      'signature': signature,
      'created': created.toIso8601String(), 
      'updateCreated': updateCreated.toIso8601String(),
    };
  }

 
}