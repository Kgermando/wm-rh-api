import 'package:postgres/postgres.dart';

import '../../models/presences/apointement_model.dart';
 

class ApointementRepository {
  final PostgreSQLConnection executor;
  final String tableName;

  ApointementRepository(this.executor, this.tableName);

  Future<List<ApointementModel>> getAllData() async {
    var data = <ApointementModel>{};

    var querySQL = "SELECT * FROM $tableName ORDER BY \"update_created\" DESC;";
    List<List<dynamic>> results = await executor.query(querySQL);
    for (var row in results) {
      data.add(ApointementModel.fromSQL(row));
    }
    return data.toList();
  }

  Future<void> insertData(ApointementModel data) async {
    await executor.transaction((ctx) async {
      await ctx.query(
          "INSERT INTO $tableName (id, reference, ref_date, matricule,"
          "apointement, signature, created, update_created)"
          "VALUES (nextval('apointements_id_seq'), @1, @2, @3, @4, @5, @6, @7)",
          substitutionValues: {
            '1': data.reference,
            '2': data.refDate,
            '3': data.matricule,
            '4': data.apointement,
            '5': data.signature,
            '6': data.created,
            '7': data.updateCreated,
          });
    });
  }

  Future<void> update(ApointementModel data) async {
    await executor.query("""UPDATE $tableName SET reference = @1, ref_date = @2, 
      matricule = @3, apointement = @4, signature = @5,
          created = @6, update_created = @7 WHERE id=@8""",
        substitutionValues: {
          '1': data.reference,
          '2': data.refDate,
          '3': data.matricule,
          '4': data.apointement,
          '5': data.signature,
          '6': data.created,
          '7': data.updateCreated,
          '8': data.id,
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

  Future<ApointementModel> getFromId(int id) async {
    var data =
        await executor.query("SELECT * FROM  $tableName WHERE \"id\" = '$id'");
    return ApointementModel(
      id: data[0][0],
      reference: data[0][1],
      refDate: data[0][2],
      matricule: data[0][3],
      apointement: data[0][4],
      signature: data[0][5],
      created: data[0][6], 
      updateCreated: data[0][7],
    );
  }
}
