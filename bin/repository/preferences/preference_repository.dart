import 'package:postgres/postgres.dart';

import '../../models/preferences/preference_model.dart';

class PreferenceRepository {
  final PostgreSQLConnection executor;
  final String tableName;

  PreferenceRepository(this.executor, this.tableName);

  Future<List<PreferenceModel>> getAllData() async {
    var data = <PreferenceModel>{};

    var querySQL = "SELECT * FROM $tableName ORDER BY \"update_created\" DESC;";
    List<List<dynamic>> results = await executor.query(querySQL);
    for (var row in results) {
      data.add(PreferenceModel.fromSQL(row));
    }
    return data.toList();
  }

  Future<void> insertData(PreferenceModel data) async {
    await executor.transaction((ctx) async {
      await ctx
          .query("""INSERT INTO $tableName (id, company_name, nbr_employe, cnss, 
        numero_taxe, rccm, id_nat, numero_impot, email, telephone, 
        adresse, date_de_paie, cnss_qpp, inpp, onem, cotisation_syndicale,
        cnss_qpo, allocation_logement, allocation_transport, nbr_max_enfant_courvert,
        allocation_familliale, allocation_epouse, nbre_heure_travail, taux_dollard,
        new_year, noel, martyr_day, kabila_day, lumumba_day, labour_day,
        liberation_day, indepence_day, parent_day, kimbangu_day, 
        signature, created, update_created) 
        VALUES (nextval('preferences_id_seq'), @1, @2, @3, @4, @5, @6, @7,
        @8, @9, @10, @11, @12, @13, @14, @15, @16, @17, @18, @19, @20, @21, @22, @23,
        @24, @25, @26, @27, @28, @29, @30, @31, @32, @33, @34, @35, @36)""",
        substitutionValues: {
            '1': data.companyName,
            '2': data.nbrEmploye,
            '3': data.cnss,
            '4': data.numeroTaxe,
            '5': data.rccm,
            '6': data.idNat,
            '7': data.numeroImpot,
            '8': data.email,
            '9': data.telephone,
            '10': data.adresse,
            '11': data.dateDePaie,
            '12': data.cnssQPP,
            '13': data.inpp,
            '14': data.onem,
            '15': data.cotisationSyndicale,
            '16': data.cnssQPO,
            '17': data.allocationLogement,
            '18': data.allocationTransport,
            '19': data.nbrMaxEnfantCourvert,
            '20': data.allocationFamilliale,
            '21': data.allocationEpouse,
            '22': data.nbreHeureTravail,
            '23': data.tauxDollard,
            '24': data.newYear,
            '25': data.noel,
            '26': data.martyrDay,
            '27': data.kabilaDay,
            '28': data.lumumbaDay,
            '29': data.labourDay,
            '30': data.liberationDay,
            '31': data.indepenceDay,
            '32': data.parentDay,
            '33': data.kimbanguDay,
            '34': data.signature,
            '35': data.created,
            '36': data.updateCreated,
          });
    });
  }

  Future<void> update(PreferenceModel data) async {
    await executor
        .query("""UPDATE $tableName SET company_name = @1, nbr_employe = @2, cnss = @3, 
      numero_taxe = @4, rccm = @5, id_nat = @6, numero_impot = @7, email = @8, telephone = @9, 
      adresse = @10, date_de_paie = @11, cnss_qpp = @12, inpp = @13, onem = @14, cotisation_syndicale = @15,
      cnss_qpo = @16, allocation_logement = @17, allocation_transport = @18, nbr_max_enfant_courvert = @19,
      allocation_familliale = @20, allocation_epouse = @21, nbre_heure_travail = @22, taux_dollard = @23,
      new_year = @24, noel = @25, martyr_day = @26, kabila_day = @27, lumumba_day = @28, labour_day = @29,
      liberation_day = @30, indepence_day = @31, parent_day = @32, kimbangu_day = @33,   
      signature = @34, created = @35, update_created = @36 WHERE id=@37""",
            substitutionValues: {
          '1': data.companyName,
          '2': data.nbrEmploye,
          '3': data.cnss,
          '4': data.numeroTaxe,
          '5': data.rccm,
          '6': data.idNat,
          '7': data.numeroImpot,
          '8': data.email,
          '9': data.telephone,
          '10': data.adresse,
          '11': data.dateDePaie,
          '12': data.cnssQPP,
          '13': data.inpp,
          '14': data.onem,
          '15': data.cotisationSyndicale,
          '16': data.cnssQPO,
          '17': data.allocationLogement,
          '18': data.allocationTransport,
          '19': data.nbrMaxEnfantCourvert,
          '20': data.allocationFamilliale,
          '21': data.allocationEpouse,
          '22': data.nbreHeureTravail,
          '23': data.tauxDollard,
          '24': data.newYear,
          '25': data.noel,
          '26': data.martyrDay,
          '27': data.kabilaDay,
          '28': data.lumumbaDay,
          '29': data.labourDay,
          '30': data.liberationDay,
          '31': data.indepenceDay,
          '32': data.parentDay,
          '33': data.kimbanguDay,
          '34': data.signature,
          '35': data.created,
          '36': data.updateCreated,
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

  Future<PreferenceModel> getFromId(int id) async {
    var data =
        await executor.query("SELECT * FROM  $tableName WHERE \"id\" = '$id'");
    return PreferenceModel(
      id: data[0][0],
      companyName: data[0][1],
      nbrEmploye: data[0][2],
      cnss: data[0][3],
      numeroTaxe: data[0][4],
      rccm: data[0][5],
      idNat: data[0][6],
      numeroImpot: data[0][7],
      email: data[0][8],
      telephone: data[0][9],
      adresse: data[0][10],
      dateDePaie: data[0][11],
      cnssQPP: data[0][12],
      inpp: data[0][13],
      onem: data[0][14],
      cotisationSyndicale: data[0][15],
      cnssQPO: data[0][16],
      allocationLogement: data[0][17],
      allocationTransport: data[0][18],
      nbrMaxEnfantCourvert: data[0][19],
      allocationFamilliale: data[0][20],
      allocationEpouse: data[0][21],
      nbreHeureTravail: data[0][22],
      tauxDollard: data[0][23],
      newYear: data[0][24],
      noel: data[0][25],
      martyrDay: data[0][26],
      kabilaDay: data[0][27],
      lumumbaDay: data[0][28],
      labourDay: data[0][29],
      liberationDay: data[0][30],
      indepenceDay: data[0][31],
      parentDay: data[0][32],
      kimbanguDay: data[0][33],
      signature: data[0][34],
      created: data[0][35],
      updateCreated: data[0][36],
    );
  }
}
