import 'package:postgres/postgres.dart';

import '../../models/preferences/site_location_model.dart';
 

class SiteLocationRepository {
  final PostgreSQLConnection executor;
  final String tableName;

  SiteLocationRepository(this.executor, this.tableName);

  Future<List<SiteLocalModel>> getAllData() async {
    var data = <SiteLocalModel>{};

    var querySQL = "SELECT * FROM $tableName ORDER BY \"update_created\" DESC;";
    List<List<dynamic>> results = await executor.query(querySQL);
    for (var row in results) {
      data.add(SiteLocalModel.fromSQL(row));
    }
    return data.toList();
  }

  Future<void> insertData(SiteLocalModel data) async {
    await executor.transaction((ctx) async {
      await ctx.query(
          "INSERT INTO $tableName (id, name, responsable, adresse,"
          "signature, created, update_created)"
          "VALUES (nextval('site_locations_id_seq'), @1, @2, @3, @4, @5, @69)",
          substitutionValues: {
            '1': data.name,
            '2': data.responsable,
            '3': data.adresse,
            '4': data.signature,
            '5': data.created,
            '6': data.updateCreated,
          });
    });
  }

  Future<void> update(SiteLocalModel data) async {
    await executor.query("""UPDATE $tableName SET name = @1, responsable = @2,
      adresse = @3, signature = @4, created = @5, update_created = @6 WHERE id=@7""",
      substitutionValues: {
          '1': data.name,
          '2': data.responsable,
          '3': data.adresse,
          '4': data.signature,
          '5': data.created,
          '6': data.updateCreated,
          '7': data.id
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

  Future<SiteLocalModel> getFromId(int id) async {
    var data =
        await executor.query("SELECT * FROM  $tableName WHERE \"id\" = '$id'");
    return SiteLocalModel(
      id: data[0][0],
      name: data[0][1],
      responsable: data[0][2],
      adresse: data[0][3],
      signature: data[0][4],
      created: data[0][5],
      updateCreated: data[0][6],
    );
  }
}
