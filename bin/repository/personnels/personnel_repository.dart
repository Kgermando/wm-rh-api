import 'package:postgres/postgres.dart';

import '../../models/personnels/personel_model.dart'; 

class PersonnelRepository {
  final PostgreSQLConnection executor;
  final String tableName;

  PersonnelRepository(this.executor, this.tableName);

  Future<List<PersonnelModel>> getAllData() async {
    var data = <PersonnelModel>{};

    var querySQL = "SELECT * FROM $tableName WHERE \"is_delete\" = 'false' ORDER BY \"update_created\" DESC;";
    List<List<dynamic>> results = await executor.query(querySQL);
    for (var row in results) {
      data.add(PersonnelModel.fromSQL(row));
    }
    return data.toList();
  }

  Future<void> insertData(PersonnelModel data) async {
    await executor.transaction((ctx) async {
      await ctx.execute(
        """INSERT INTO $tableName (id, photo, nom, postnom, prenom, email, 
        telephone, adresse, sexe, date_naissance, lieu_naissance, nationalite, 
        etat_civile, nbr_enfant, nbr_dependants, nbr_dependants_max,
        matricule, numero_cnss, role, departement, title, fonction, services, 
        site_location, type_contrat, date_debut_contrat, date_fin_contrat,
        salaire, compte_bancaire, nom_banque, frais_bancaire, 
        statut_personnel, cv_url, signature, created, update_created, is_delete)
        VALUES (nextval('personnels_id_seq'), @1, @2, @3, @4, @5, @6, @7, @8,
          @9, @10, @11, @12, @13, @14, @15, @16, @17, @18, @19, @20, @21, @22, 
          @23, @24, @25, @26, @27, @28, @29, @30, @31, @32, @33, @34, @35, @36)""",
          substitutionValues: {
            '1': data.photo,
            '2': data.nom,
            '3': data.postnom,
            '4': data.prenom,
            '5': data.email,
            '6': data.telephone,
            '7': data.adresse,
            '8': data.sexe,
            '9': data.dateNaissance,
            '10': data.lieuNaissance,
            '11': data.nationalite,
            '12': data.etatCivile,
            '13': data.nbrEnfant,
            '14': data.nbrDependants,
            '15': data.nbrDependantsMax,
            '16': data.matricule,
            '17': data.numeroCNSS,
            '18': data.role,
            '19': data.departement,
            '20': data.title,
            '21': data.fonction,
            '22': data.services,
            '23': data.siteLocation,
            '24': data.typeContrat,
            '25': data.dateDebutContrat,
            '26': data.dateFinContrat,
            '27': data.salaire,
            '28': data.compteBancaire,
            '29': data.nomBanque,
            '30': data.fraisBancaire,
            '31': data.statutPersonnel,
            '32': data.cvUrl,
            '33': data.signature,
            '34': data.created,
            '35': data.updateCreated,
            '36': data.isDelete,
          });
    });
  }

  Future<void> update(PersonnelModel data) async {
    await executor.query("""UPDATE $tableName
        SET photo = @1, nom = @2, postnom = @3, prenom = @4, 
        email = @5, telephone = @6, adresse = @7, sexe = @8, date_naissance = @9, 
        lieu_naissance = @10, nationalite = @11, etat_civile = @12, nbr_enfant = @13, 
        nbr_dependants = @14, nbr_dependants_max = @15, matricule = @16, numero_cnss = @17,
        role = @18, departement = @19, title = @20, fonction = @21, services = @22,
        site_location = @23, type_contrat = @24, date_debut_contrat = @25, date_fin_contrat = @26,
        salaire = @27, compte_bancaire = @28, nom_banque = @29, frais_bancaire = @30,
        statut_personnel = @31, cv_url = @32, signature = @33, created = @34, 
        update_created = @35, is_delete = @36 WHERE id = @37""", substitutionValues: {
      '1': data.photo,
      '2': data.nom,
      '3': data.postnom,
      '4': data.prenom,
      '5': data.email,
      '6': data.telephone,
      '7': data.adresse,
      '8': data.sexe,
      '9': data.dateNaissance,
      '10': data.lieuNaissance,
      '11': data.nationalite,
      '12': data.etatCivile,
      '13': data.nbrEnfant,
      '14': data.nbrDependants,
      '15': data.nbrDependantsMax,
      '16': data.matricule,
      '17': data.numeroCNSS,
      '18': data.role,
      '19': data.departement,
      '20': data.title,
      '21': data.fonction,
      '22': data.services,
      '23': data.siteLocation,
      '24': data.typeContrat,
      '25': data.dateDebutContrat,
      '26': data.dateFinContrat,
      '27': data.salaire,
      '28': data.compteBancaire,
      '29': data.nomBanque,
      '30': data.fraisBancaire,
      '31': data.statutPersonnel,
      '32': data.cvUrl,
      '33': data.signature,
      '34': data.created,
      '35': data.updateCreated,
      '36': data.isDelete,
      '37': data.id
    });
  }

  deleteData(int id) async {
    try {
      await executor.transaction((conn) async {
        // ignore: unused_local_variable
        var result = await conn.execute('DELETE FROM $tableName WHERE id=$id;');
      });
    } catch (e) {
      'erreur $e';
    }
  }

  Future<PersonnelModel> getFromId(int id) async {
    var data =
        await executor.query("SELECT * FROM  $tableName WHERE \"id\" = '$id'");
    return PersonnelModel(
      id: data[0][0],
      photo: data[0][1],
      nom: data[0][2],
      postnom: data[0][3],
      prenom: data[0][4],
      email: data[0][5],
      telephone: data[0][6],
      adresse: data[0][7],
      sexe: data[0][8],
      dateNaissance: data[0][9],
      lieuNaissance: data[0][10],
      nationalite: data[0][11],
      etatCivile: data[0][12],
      nbrEnfant: data[0][13],
      nbrDependants: data[0][14],
      nbrDependantsMax: data[0][15],

      matricule: data[0][16],
      numeroCNSS: data[0][17],
      role: data[0][18],

      departement: data[0][19],
      title: data[0][20], 
      fonction: data[0][21],
      services: data[0][22],
      siteLocation: data[0][23],

      typeContrat: data[0][24],
      dateDebutContrat: data[0][25], 
      dateFinContrat: data[0][26],

      salaire: data[0][27], 
      compteBancaire: data[0][28],
      nomBanque: data[0][29],
      fraisBancaire: data[0][30],

      statutPersonnel: data[0][31], 
      cvUrl: data[0][32],
      signature: data[0][33],
      created: data[0][34],
      updateCreated: data[0][35],
      isDelete: data[0][36],
    );
  }
}