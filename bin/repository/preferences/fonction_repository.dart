import 'package:postgres/postgres.dart';

import '../../models/preferences/fonction_model.dart';

class FonctionRepository {
  final PostgreSQLConnection executor;
  final String tableName;

  FonctionRepository(this.executor, this.tableName);

  Future<List<FonctionModel>> getAllData() async {
    var data = <FonctionModel>{};

    var querySQL = "SELECT * FROM $tableName ORDER BY \"update_created\" DESC;";
    List<List<dynamic>> results = await executor.query(querySQL);
    for (var row in results) {
      data.add(FonctionModel.fromSQL(row));
    }
    return data.toList();
  }

  Future<void> insertData(FonctionModel data) async {
    await executor.transaction((ctx) async {
      await ctx.query(
          "INSERT INTO $tableName (id, title, fonction, services,"
          "signature, created, update_created)"
          "VALUES (nextval('fonctions_id_seq'), @1, @2, @3, @4, @5, @6)",
          substitutionValues: {
            '1': data.title,
            '2': data.fonction,
            '3': data.services,
            '4': data.signature,
            '5': data.created,
            '6': data.updateCreated,
          });
    });
  }

  Future<void> update(FonctionModel data) async {
    await executor.query("""UPDATE $tableName SET title = @1, fonction = @2,
          services = @3, signature = @4, created = @5,
          update_created = @6 WHERE id=@7""",
        substitutionValues: {
          '1': data.title,
          '2': data.fonction,
          '3': data.services,
          '4': data.signature,
          '5': data.created,
          '6': data.updateCreated,
          '7': data.id,
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

  Future<FonctionModel> getFromId(int id) async {
    var data =
        await executor.query("SELECT * FROM  $tableName WHERE \"id\" = '$id'");
    return FonctionModel(
      id: data[0][0],
      title: data[0][1],
      fonction: data[0][2],
      services: data[0][3],
      signature: data[0][4],
      created: data[0][5], 
      updateCreated: data[0][6],
    );
  }
}
