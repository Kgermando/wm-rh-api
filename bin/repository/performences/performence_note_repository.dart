import 'package:postgres/postgres.dart';

import '../../models/performences/perfomence_model.dart';

class PerformenceNoteRepository {
  final PostgreSQLConnection executor;
  final String tableName;

  PerformenceNoteRepository(this.executor, this.tableName);

  Future<List<PerformenceNoteModel>> getAllData() async {
    var data = <PerformenceNoteModel>{};
    var querySQL = "SELECT * FROM $tableName ORDER BY \"update_created\" DESC;";
    List<List<dynamic>> results = await executor.query(querySQL);
    for (var row in results) {
      data.add(PerformenceNoteModel.fromSQL(row));
    }
    return data.toList();
  }

  Future<void> insertData(PerformenceNoteModel performenceModel) async {
    await executor.transaction((ctx) async {
      await ctx.query(
        "INSERT INTO $tableName (id, reference, matricule, departement, hospitalite,"
        "ponctualite, travaille, note, signature, created, update_created)"
        "VALUES (nextval('performences_note_id_seq'), @1, @2, @3, @4, @5, @6,"
        "@7, @8, @9, @10)",
        substitutionValues: {
          '1': performenceModel.reference,
          '2': performenceModel.matricule,
          '3': performenceModel.departement,
          '4': performenceModel.hospitalite,
          '5': performenceModel.ponctualite,
          '6': performenceModel.travaille,
          '7': performenceModel.note,
          '8': performenceModel.signature,
          '9': performenceModel.created,
          '10': performenceModel.updateCreated
          }
        );
    });
  }

  Future<void> update(PerformenceNoteModel performenceModel) async {
    await executor.query("""UPDATE $tableName SET reference = @1, matricule = @2,
      hospitalite = @3, departement = @4, ponctualite = @5, travaille = @6,
      note = @7, signature = @8, created = @9, update_created = @10 WHERE id=@11""",
      substitutionValues: {
        '1': performenceModel.reference,
        '2': performenceModel.matricule,
        '3': performenceModel.departement,
        '4': performenceModel.hospitalite,
        '5': performenceModel.ponctualite,
        '6': performenceModel.travaille,
        '7': performenceModel.note,
        '8': performenceModel.signature,
        '9': performenceModel.created,
        '10': performenceModel.updateCreated,
        '11': performenceModel.id
        }
      );
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

  Future<PerformenceNoteModel> getFromId(int id) async {
    var data =
        await executor.query("SELECT * FROM  $tableName WHERE \"id\" = '$id'");
    return PerformenceNoteModel(
      id: data[0][0],
      reference: data[0][1],
      matricule: data[0][2],
      departement: data[0][3],
      hospitalite: data[0][4],
      ponctualite: data[0][5],
      travaille: data[0][6],
      note: data[0][7],
      signature: data[0][8],
      created: data[0][9],
      updateCreated: data[0][10],
    );
  }
}
