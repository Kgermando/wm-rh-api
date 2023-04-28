import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../models/recrutements/candidature_model.dart';
import '../../repository/repository.dart';

class CandidatureHandlers {
  final Repository repos;

  CandidatureHandlers(this.repos);

  Router get router {
    final router = Router();

    router.get('/', (Request request) async {
      List<CandidatureModel> data = await repos.candidatures.getAllData();
      return Response.ok(jsonEncode(data));
    });

    router.get('/<id>', (Request request, String id) async {
      late CandidatureModel data;
      try {
        data = await repos.candidatures.getFromId(int.parse(id));
      } catch (e) {
        print(e);
        return Response(404);
      }
      return Response.ok(jsonEncode(data.toJson()));
    });

    router.post('/insert-candidature', (Request request) async {
      var input = jsonDecode(await request.readAsString());

      CandidatureModel data = CandidatureModel(
        reference: input['reference'],
        scanUrl: input['scanUrl'],
        fullName: input['fullName'],
        sexe: input['sexe'],
        departement: input['departement'],
        statut: input['statut'],
        signature: input['signature'],
        created: DateTime.parse(input['created']),
        updateCreated: DateTime.parse(input['updateCreated']),
      );
      try {
        await repos.candidatures.insertData(data);
      } catch (e) {
        print(e);
        return Response(422);
      }
      return Response.ok(jsonEncode(data.toJson()));
    });

    router.put('/update-candidature/', (Request request) async {
      dynamic input = jsonDecode(await request.readAsString());
      final editH = CandidatureModel.fromJson(input);
      CandidatureModel? data = await repos.candidatures.getFromId(editH.id!);

      if (input['reference'] != null) {
        data.reference = input['reference'];
      }
      if (input['scanUrl'] != null) {
        data.scanUrl = input['scanUrl'];
      }
      if (input['fullName'] != null) {
        data.fullName = input['fullName'];
      }
      if (input['sexe'] != null) {
        data.sexe = input['sexe'];
      }
      if (input['departement'] != null) {
        data.departement = input['departement'];
      }
      if (input['statut'] != null) {
        data.statut = input['statut'];
      }
      if (input['signature'] != null) {
        data.signature = input['signature'];
      } 
      if (input['created'] != null) {
        data.created = DateTime.parse(input['created']);
      }
      if (input['updateCreated'] != null) {
        data.updateCreated = DateTime.parse(input['updateCreated']);
      }

      repos.candidatures.update(data);
      return Response.ok(jsonEncode(data.toJson()));
    });

    router.delete('/delete-candidature/<id>', (Request request, String id) async {
      var id = request.params['id'];
      repos.candidatures.deleteData(int.parse(id!));
      return Response.ok('Supprimée');
    });

    router.all(
      '/<ignored|.*>',
      (Request request) =>
          Response.notFound('La Page candidatures n\'est pas trouvé'),
    );

    return router;
  }
}
