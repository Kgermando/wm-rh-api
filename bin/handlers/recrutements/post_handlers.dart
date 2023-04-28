import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../models/recrutements/poste_model.dart';
import '../../repository/repository.dart';

class PostHandlers {
  final Repository repos;

  PostHandlers(this.repos);

  Router get router {
    final router = Router();

    router.get('/', (Request request) async {
      List<PosteModel> data = await repos.posts.getAllData();
      return Response.ok(jsonEncode(data));
    });

    router.get('/<id>', (Request request, String id) async {
      late PosteModel data;
      try {
        data = await repos.posts.getFromId(int.parse(id));
      } catch (e) {
        print(e);
        return Response(404);
      }
      return Response.ok(jsonEncode(data.toJson()));
    });

    router.post('/insert-post', (Request request) async {
      var input = jsonDecode(await request.readAsString());

      PosteModel data = PosteModel(
        statut: input['statut'],
        searchProfil: input['searchProfil'],
        sexe: input['sexe'],
        salaire: input['salaire'],
        typeContrat: input['typeContrat'],
        signature: input['signature'],
        created: DateTime.parse(input['created']),
        updateCreated: DateTime.parse(input['updateCreated']),
      );
      try {
        await repos.posts.insertData(data);
      } catch (e) {
        print(e);
        return Response(422);
      }
      return Response.ok(jsonEncode(data.toJson()));
    });

    router.put('/update-post/', (Request request) async {
      dynamic input = jsonDecode(await request.readAsString());
      final editH = PosteModel.fromJson(input);
      PosteModel? data = await repos.posts.getFromId(editH.id!);

      if (input['statut'] != null) {
        data.statut = input['statut'];
      }
      if (input['searchProfil'] != null) {
        data.searchProfil = input['searchProfil'];
      }
      if (input['sexe'] != null) {
        data.sexe = input['sexe'];
      }
      if (input['salaire'] != null) {
        data.salaire = input['salaire'];
      }
      if (input['typeContrat'] != null) {
        data.typeContrat = input['typeContrat'];
      }
      if (input['signature'] != null) {
        data.signature = input['signature'];
      } 
      if (input['created'] != null) {
        data.created = DateTime.parse(input['created']);
      }
      if (input['created'] != null) {
        data.created = DateTime.parse(input['created']);
      }
      repos.posts.update(data);
      return Response.ok(jsonEncode(data.toJson()));
    });

    router.delete('/delete-post/<id>', (Request request, String id) async {
      var id = request.params['id'];
      repos.posts.deleteData(int.parse(id!));
      return Response.ok('Supprimée');
    });

    router.all(
      '/<ignored|.*>',
      (Request request) =>
          Response.notFound('La Page posts n\'est pas trouvé'),
    );

    return router;
  }
}
