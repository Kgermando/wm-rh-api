import 'package:postgres/postgres.dart';

import '../../models/settings/monnaie_model.dart';

class MonnaieRepository {
  final PostgreSQLConnection executor;
  final String tableName;

  MonnaieRepository(this.executor, this.tableName);

  Future<List<MonnaieModel>> getAllData() async {
    var data = <MonnaieModel>{};

    var querySQL = "SELECT * FROM $tableName ORDER BY \"created\" DESC;";
    List<List<dynamic>> results = await executor.query(querySQL);
    for (var row in results) {
      data.add(MonnaieModel.fromSQL(row));
    }
    return data.toList();
  }

  Future<void> insertData(MonnaieModel data) async {
    await executor.transaction((ctx) async {
      await ctx.execute(
        "INSERT INTO $tableName (id, monnaie, monnaie_en_lettre,"
        "is_active, signature, created, update_created)"
        "VALUES (nextval('monnaies_id_seq'), @1, @2, @3, @4, @5, @6)",
        substitutionValues: {
          '1': data.monnaie,
          '2': data.monnaieEnlettre,
          '3': data.isActive,
          '4': data.signature,
          '5': data.created,
          '6': data.updateCreated,
        }
      );
    });
  }

  Future<void> update(MonnaieModel data) async {
    await executor.query("""UPDATE $tableName
      SET monnaie = @1, monnaie_en_lettre = @2, is_active = @3,
      signature = @4, created = @5, update_created = @6 WHERE id = @7""", substitutionValues: {
      '1': data.monnaie,
      '2': data.monnaieEnlettre,
      '3': data.isActive,
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

  Future<MonnaieModel> getFromId(int id) async {
    var data =
        await executor.query("SELECT * FROM  $tableName WHERE \"id\" = '$id'");
    return MonnaieModel(
      id: data[0][0],
      monnaie: data[0][1],
      monnaieEnlettre: data[0][2],
      isActive: data[0][3],
      signature: data[0][4],
      created: data[0][5],
      updateCreated: data[0][6],
    );
  }
}