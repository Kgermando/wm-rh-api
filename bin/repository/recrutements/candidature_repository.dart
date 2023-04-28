import 'package:postgres/postgres.dart';

import '../../models/recrutements/candidature_model.dart';
 
class CandidatureRepository {
  final PostgreSQLConnection executor;
  final String tableName;

  CandidatureRepository(this.executor, this.tableName);

  Future<List<CandidatureModel>> getAllData() async {
    var data = <CandidatureModel>{};

    var querySQL = "SELECT * FROM $tableName ORDER BY \"update_created\" DESC;";
    List<List<dynamic>> results = await executor.query(querySQL);
    for (var row in results) {
      data.add(CandidatureModel.fromSQL(row));
    }
    return data.toList();
  }

  Future<void> insertData(CandidatureModel data) async {
    await executor.transaction((ctx) async {
      await ctx.query(
          "INSERT INTO $tableName (id, reference, scan_url, full_name,"
          "sexe, departement, statut, signature, created, update_created)"
          "VALUES (nextval('candidatures_id_seq'), @1, @2, @3, @4, @5, @6, @7, @8, @9)",
          substitutionValues: {
            '1': data.reference,
            '2': data.scanUrl,
            '3': data.fullName,
            '4': data.sexe,
            '5': data.departement,
            '6': data.statut,
            '7': data.signature,
            '8': data.created,
            '9': data.updateCreated,
          });
    });
  }

  Future<void> update(CandidatureModel data) async {
    await executor.query("""UPDATE $tableName SET reference = @1, scan_url = @2,
      full_name = @3, sexe = @4, departement = @5, statut = @6, signature = @7,
      created = @8, update_created = @9 WHERE id=@10""",
        substitutionValues: {
          '1': data.reference,
          '2': data.scanUrl,
          '3': data.fullName,
          '4': data.sexe,
          '5': data.departement,
          '6': data.statut,
          '7': data.signature,
          '8': data.created,
          '9': data.updateCreated,
          '10': data.id,
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

  Future<CandidatureModel> getFromId(int id) async {
    var data =
        await executor.query("SELECT * FROM  $tableName WHERE \"id\" = '$id'");
    return CandidatureModel(
      id: data[0][0],
      reference: data[0][1],
      scanUrl: data[0][2],
      fullName: data[0][3],
      sexe: data[0][4],
      departement: data[0][5],
      statut: data[0][6],
      signature: data[0][7],
      created: data[0][8],
      updateCreated: data[0][9],
    );
  }
}
