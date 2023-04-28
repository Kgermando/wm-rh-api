import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../models/preferences/departement_model.dart';
import '../../repository/repository.dart';

class DepartementHandlers {
  final Repository repos;

  DepartementHandlers(this.repos);

  Router get router {
    final router = Router();

    router.get('/', (Request request) async {
      List<DepartementModel> data = await repos.departements.getAllData();
      return Response.ok(jsonEncode(data));
    });

    router.get('/<id>', (Request request, String id) async {
      late DepartementModel data;
      try {
        data = await repos.departements.getFromId(int.parse(id));
      } catch (e) {
        print(e);
        return Response(404);
      }
      return Response.ok(jsonEncode(data.toJson()));
    });

    router.post('/insert-departement', (Request request) async {
      var input = jsonDecode(await request.readAsString());

      DepartementModel data = DepartementModel(
        departement: input['departement'],
        signature: input['signature'],
        created: DateTime.parse(input['created']),
        updateCreated: DateTime.parse(input['updateCreated']),
      );
      try {
        await repos.departements.insertData(data);
      } catch (e) {
        print(e);
        return Response(422);
      }
      return Response.ok(jsonEncode(data.toJson()));
    });

    router.put('/update-departement/', (Request request) async {
      dynamic input = jsonDecode(await request.readAsString());
      final editH = DepartementModel.fromJson(input);
      DepartementModel? data = await repos.departements.getFromId(editH.id!);

      if (input['departement'] != null) {
        data.departement = input['departement'];
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

      repos.departements.update(data);
      return Response.ok(jsonEncode(data.toJson()));
    });

    router.delete('/delete-departement/<id>', (Request request, String id) async {
      var id = request.params['id'];
      repos.departements.deleteData(int.parse(id!));
      return Response.ok('Supprimée');
    });

    router.all(
      '/<ignored|.*>',
      (Request request) =>
          Response.notFound('La Page departements n\'est pas trouvé'),
    );

    return router;
  }
}
