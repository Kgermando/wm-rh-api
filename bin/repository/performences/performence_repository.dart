import 'package:postgres/postgres.dart';

import '../../models/performences/perfomence_model.dart';

class PerformenceRepository {
  final PostgreSQLConnection executor;
  final String tableName;

  PerformenceRepository(this.executor, this.tableName);

  Future<List<PerformenceModel>> getAllData() async {
    var data = <PerformenceModel>{};

    var querySQL = "SELECT * FROM $tableName ORDER BY \"update_created\" DESC;";
    List<List<dynamic>> results = await executor.query(querySQL);
    for (var row in results) {
      data.add(PerformenceModel.fromSQL(row));
    }
    return data.toList();
  }

  Future<void> insertData(PerformenceModel data) async {
    await executor.transaction((ctx) async {
      await ctx.execute(
        "INSERT INTO $tableName (id, matricule, departement, nom, postnom,"
        "prenom, signature, created, update_created)"
        "VALUES (nextval('performences_id_seq'), @1, @2, @3, @4, @5, @6, @7, @8)",
          substitutionValues: {
            '1': data.matricule,
            '2': data.departement,
            '3': data.nom,
            '4': data.postnom,
            '5': data.prenom,
            '6': data.signature,
            '7': data.created,
            '8': data.updateCreated
          });
    });
  }

  Future<void> update(PerformenceModel data) async {
    await executor.query("""UPDATE $tableName
        SET matricule = @1, departement = @2, nom = @3, postnom = @4, prenom = @5,
        signature = @6, created = @7, update_created = @8 WHERE id = @9""", 
    substitutionValues: {
      '1': data.matricule,
      '2': data.departement,
      '3': data.prenom,
      '4': data.nom,
      '5': data.postnom,
      '6': data.signature,
      '7': data.created,
      '8': data.updateCreated,
      '9': data.id
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

  Future<PerformenceModel> getFromId(int id) async {
    var data =
        await executor.query("SELECT * FROM  $tableName WHERE \"id\" = '$id'");
    return PerformenceModel(
      id: data[0][0],
      matricule: data[0][1],
      departement: data[0][2],
      nom: data[0][3],
      postnom: data[0][4],
      prenom: data[0][5],
      signature: data[0][6],
      created: data[0][7],
      updateCreated: data[0][8],
    );
  }
}