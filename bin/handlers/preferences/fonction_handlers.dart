import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../models/preferences/fonction_model.dart';
import '../../repository/repository.dart';

class FonctionHandlers {
  final Repository repos;

  FonctionHandlers(this.repos);

  Router get router {
    final router = Router();

    router.get('/', (Request request) async {
      List<FonctionModel> data = await repos.fonctions.getAllData();
      return Response.ok(jsonEncode(data));
    });

    router.get('/<id>', (Request request, String id) async {
      late FonctionModel data;
      try {
        data = await repos.fonctions.getFromId(int.parse(id));
      } catch (e) {
        print(e);
        return Response(404);
      }
      return Response.ok(jsonEncode(data.toJson()));
    });

    router.post('/insert-fonction', (Request request) async {
      var input = jsonDecode(await request.readAsString());
      FonctionModel data = FonctionModel(
        title: input['title'],
        fonction: input['fonction'],
        services: input['services'],
        signature: input['signature'],
        created: DateTime.parse(input['created']),
        updateCreated: DateTime.parse(input['updateCreated']),
      ); 
      try {
        await repos.fonctions.insertData(data);
      } catch (e) {
        print(e);
        return Response(422);
      }
      return Response.ok(jsonEncode(data.toJson()));
    });

    router.put('/update-fonction/', (Request request) async {
      dynamic input = jsonDecode(await request.readAsString());
      final editH = FonctionModel.fromJson(input);
      FonctionModel? data = await repos.fonctions.getFromId(editH.id!);

      if (input['title'] != null) {
        data.title = input['title'];
      }
      if (input['fonction'] != null) {
        data.fonction = input['fonction'];
      }
      if (input['services'] != null) {
        data.services = input['services'];
      } 
      if (input['created'] != null) {
        data.created = DateTime.parse(input['created']);
      }
      if (input['updateCreated'] != null) {
        data.updateCreated = DateTime.parse(input['updateCreated']);
      }

      repos.fonctions.update(data);
      return Response.ok(jsonEncode(data.toJson()));
    });

    router.delete('/delete-fonction/<id>', (Request request, String id) async {
      var id = request.params['id'];
      repos.fonctions.deleteData(int.parse(id!));
      return Response.ok('Supprimée');
    });

    router.all(
      '/<ignored|.*>',
      (Request request) =>
          Response.notFound('La Page fonctions n\'est pas trouvé'),
    );

    return router;
  }
}
