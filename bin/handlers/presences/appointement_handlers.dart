import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
 
import '../../models/presences/apointement_model.dart';
import '../../repository/repository.dart';

class ApointementHandlers {
  final Repository repos;

  ApointementHandlers(this.repos);

  Router get router {
    final router = Router();

    router.get('/', (Request request) async {
      List<ApointementModel> data = await repos.apointements.getAllData();
      return Response.ok(jsonEncode(data));
    });

    router.get('/<id>', (Request request, String id) async {
      late ApointementModel data;
      try {
        data = await repos.apointements.getFromId(int.parse(id));
      } catch (e) {
        print(e);
        return Response(404);
      }
      return Response.ok(jsonEncode(data.toJson()));
    });

    router.post('/insert-apointement', (Request request) async {
      var input = jsonDecode(await request.readAsString());

      ApointementModel data = ApointementModel(
        reference: input['reference'],
        refDate: input['refDate'],
        matricule: input['matricule'],
        apointement: input['apointement'],
        signature: input['signature'],
        created: DateTime.parse(input['created']),
        updateCreated: DateTime.parse(input['updateCreated']),
      );
      try {
        await repos.apointements.insertData(data);
      } catch (e) {
        print(e);
        return Response(422);
      }
      return Response.ok(jsonEncode(data.toJson()));
    });

    router.put('/update-apointement/', (Request request) async {
      dynamic input = jsonDecode(await request.readAsString());
      final editH = ApointementModel.fromJson(input);
      ApointementModel? data = await repos.apointements.getFromId(editH.id!);

      if (input['reference'] != null) {
        data.reference = input['reference'];
      }
      if (input['refDate'] != null) {
        data.refDate = input['refDate'];
      }
      if (input['matricule'] != null) {
        data.matricule = input['matricule'];
      }
      if (input['apointement'] != null) {
        data.apointement = input['apointement'];
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

      repos.apointements.update(data);
      return Response.ok(jsonEncode(data.toJson()));
    });

    router.delete('/delete-apointement/<id>', (Request request, String id) async {
      var id = request.params['id'];
      repos.apointements.deleteData(int.parse(id!));
      return Response.ok('Supprimée');
    });

    router.all(
      '/<ignored|.*>',
      (Request request) =>
          Response.notFound('La Page apointements n\'est pas trouvé'),
    );

    return router;
  }
}
