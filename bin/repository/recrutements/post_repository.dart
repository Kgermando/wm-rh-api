import 'package:postgres/postgres.dart';

import '../../models/recrutements/poste_model.dart';
 

class PostRepository {
  final PostgreSQLConnection executor;
  final String tableName;

  PostRepository(this.executor, this.tableName);

  Future<List<PosteModel>> getAllData() async {
    var data = <PosteModel>{};

    var querySQL = "SELECT * FROM $tableName ORDER BY \"update_created\" DESC;";
    List<List<dynamic>> results = await executor.query(querySQL);
    for (var row in results) {
      data.add(PosteModel.fromSQL(row));
    }
    return data.toList();
  }

  Future<void> insertData(PosteModel data) async {
    await executor.transaction((ctx) async {
      await ctx.query(
          "INSERT INTO $tableName (id, statut, search_profil, sexe, salaire,"
          "type_contrat, signature, created, update_created)"
          "VALUES (nextval('posts_id_seq'), @1, @2, @3, @4, @5, @6, @7, @8)",
          substitutionValues: {
            '1': data.statut,
            '2': data.searchProfil,
            '3': data.sexe,
            '4': data.salaire,
            '5': data.typeContrat,
            '6': data.signature,
            '7': data.created,
            '8': data.updateCreated,
          });
    });
  }

  Future<void> update(PosteModel data) async {
    await executor.query("""UPDATE $tableName SET statut = @1, 
      search_profil = @2, sexe = @3, salaire = @4, type_contrat = @5, signature = @6,
          created = @7, update_created = @8 WHERE id=@9""",
        substitutionValues: {
         '1': data.statut,
          '2': data.searchProfil,
          '3': data.sexe,
          '4': data.salaire,
          '5': data.typeContrat,
          '6': data.signature,
          '7': data.created,
          '8': data.updateCreated,
          '9': data.id,
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

  Future<PosteModel> getFromId(int id) async {
    var data =
        await executor.query("SELECT * FROM  $tableName WHERE \"id\" = '$id'");
    return PosteModel(
      id: data[0][0],
      statut: data[0][1],
      searchProfil: data[0][2],
      sexe: data[0][3],
      salaire: data[0][4],
      typeContrat: data[0][5],
      signature: data[0][6],
      created: data[0][7],
      updateCreated: data[0][8],
    );
  }
}
