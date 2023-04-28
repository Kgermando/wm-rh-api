import 'package:postgres/postgres.dart';

import '../../models/preferences/departement_model.dart';
 

class DepartementRepository {
  final PostgreSQLConnection executor;
  final String tableName;

  DepartementRepository(this.executor, this.tableName);

  Future<List<DepartementModel>> getAllData() async {
    var data = <DepartementModel>{};

    var querySQL = "SELECT * FROM $tableName ORDER BY \"update_created\" DESC;";
    List<List<dynamic>> results = await executor.query(querySQL);
    for (var row in results) {
      data.add(DepartementModel.fromSQL(row));
    }
    return data.toList();
  }

  Future<void> insertData(DepartementModel data) async {
    await executor.transaction((ctx) async {
      await ctx.query(
          "INSERT INTO $tableName (id, departement, signature, created, update_created)"
          "VALUES (nextval('departements_id_seq'), @1, @2, @3, @4)",
          substitutionValues: {
            '1': data.departement,
            '2': data.signature,
            '3': data.created,
            '4': data.updateCreated,
          });
    });
  }

  Future<void> update(DepartementModel data) async {
    await executor.query("""UPDATE $tableName SET departement = @1, signature = @2,
          created = @3, update_created = @4 WHERE id=@5""",
        substitutionValues: {
          '1': data.departement,
          '2': data.signature,
          '3': data.created,
          '4': data.updateCreated,
          '5': data.id,
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

  Future<DepartementModel> getFromId(int id) async {
    var data =
        await executor.query("SELECT * FROM  $tableName WHERE \"id\" = '$id'");
    return DepartementModel(
      id: data[0][0],
      departement: data[0][1],
      signature: data[0][2],
      created: data[0][3],
      updateCreated: data[0][4],
    );
  }
}
