import 'package:postgres/postgres.dart';

import '../../models/users/user_model.dart';

class UserRepository {
  final PostgreSQLConnection executor;
  final String tableName;

  UserRepository(this.executor, this.tableName);

  Future<bool> isUniqueLogin(String matricule) async {
    var data = await executor
        .query("SELECT * FROM  $tableName WHERE \"matricule\" = '$matricule'");
    return data.isEmpty ? true : data[0].isEmpty;
  }

  Future<int> getIdFromLoginPassword(
      String matricule, String passwordHash) async {
    var data = await executor.query(
        "SELECT id FROM $tableName WHERE \"matricule\"='$matricule' AND \"password_hash\"='$passwordHash'");
    return data[0][0];
  }

  Future<List<UserModel>> getAllData() async {
    var data = <UserModel>{};

    var querySQL = "SELECT * FROM $tableName ORDER BY \"created_at\" DESC;";
    List<List<dynamic>> results = await executor.query(querySQL);
    for (var row in results) {
      data.add(UserModel.fromSQL(row));
    }
    return data.toList();
  }

  Future<void> insertData(UserModel data) async {
    await executor.transaction((ctx) async {
      await ctx.execute(
          "INSERT INTO $tableName (id, photo, nom, postnom, prenom, email, telephone,"
          "adresse, sexe, nationalite, etat_civile,"
          "matricule, numero_cnss, role,"
          "departement, title, fonction, services, site_location,"
          "signature, created, update_created, password_hash)"
          "VALUES (nextval('users_id_seq'), @1, @2, @3, @4, @5, @6, @7,"
          "@8, @9, @10, @11, @12, @13, @14, @15, @16, @17, @18, @19, @20, @21, @22)",
          substitutionValues: {
            '1': data.photo,
            '2': data.nom,
            '3': data.postnom,
            '4': data.prenom,
            '5': data.email,
            '6': data.telephone,
            '7': data.adresse,
            '8': data.sexe,
            '9': data.nationalite,
            '10': data.etatCivile,
            '11': data.matricule,
            '12': data.numeroCNSS,
            '13': data.role,
            '14': data.departement,
            '15': data.title,
            '16': data.fonction,
            '17': data.services,
            '18': data.siteLocation,
            '19': data.signature,
            '20': data.created,
            '21': data.updateCreated,
            '22': data.passwordHash,
          });
    });
  }

  Future<void> update(UserModel data) async {
    await executor.execute("""UPDATE $tableName
      SET photo = @1, nom = @2, postnom = @3, prenom = @4, email = @5, telephone = @6,
      adresse = @7, sexe = @8, nationalite = @9, etat_civile = @10, matricule = @11,
      numeroCNSS = @12, role = @13, departement = @14, title = @15,
      fonction = @16, services = @17, site_location = @18, signature = @19,"
      "created = @20, update_created = @21, password_hash = @22 WHERE id = @23""",
        substitutionValues: {
          '1': data.photo,
          '2': data.nom,
          '3': data.postnom,
          '4': data.prenom,
          '5': data.email,
          '6': data.telephone,
          '7': data.adresse,
          '8': data.sexe,
          '9': data.nationalite,
          '10': data.etatCivile,
          '11': data.matricule,
          '12': data.numeroCNSS,
          '13': data.role,
          '14': data.departement,
          '15': data.title,
          '16': data.fonction,
          '17': data.services,
          '18': data.siteLocation,
          '19': data.signature,
          '20': data.created,
          '21': data.updateCreated,
          '22': data.passwordHash,
          '23': data.id
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

  Future<UserModel> getFromId(int id) async {
    var data =
        await executor.query("SELECT * FROM  $tableName WHERE \"id\"='$id'");
    return UserModel(
      id: data[0][0],
      photo: data[0][1],
      nom: data[0][2],
      postnom: data[0][3],
      prenom: data[0][4],
      email: data[0][5],
      telephone: data[0][6],
      adresse: data[0][7],
      sexe: data[0][8],
      nationalite: data[0][9],
      etatCivile: data[0][10],
      matricule: data[0][11],
      numeroCNSS: data[0][12],
      role: data[0][13],
      departement: data[0][14],
      title: data[0][15],
      fonction: data[0][16],
      services: data[0][17],
      siteLocation: data[0][18],
      signature: data[0][19],
      created: data[0][20],
      updateCreated: data[0][21],
      passwordHash: data[0][22],
    );
  }
}
