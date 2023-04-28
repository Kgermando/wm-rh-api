import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
 
import '../../models/preferences/site_location_model.dart';
import '../../repository/repository.dart';

class SiteLocationHandlers {
  final Repository repos;

  SiteLocationHandlers(this.repos);

  Router get router {
    final router = Router();

    router.get('/', (Request request) async {
      List<SiteLocalModel> data = await repos.siteLocations.getAllData();
      return Response.ok(jsonEncode(data));
    });

    router.get('/<id>', (Request request, String id) async {
      late SiteLocalModel data;
      try {
        data = await repos.siteLocations.getFromId(int.parse(id));
      } catch (e) {
        print(e);
        return Response(404);
      }
      return Response.ok(jsonEncode(data.toJson()));
    });

    router.post('/insert-site-location', (Request request) async {
      var input = jsonDecode(await request.readAsString());

      SiteLocalModel data = SiteLocalModel(
        name: input['name'],
        responsable: input['responsable'],
        adresse: input['adresse'],
        signature: input['signature'],
        created: DateTime.parse(input['created']),
        updateCreated: DateTime.parse(input['updateCreated']),
      );
      try {
        await repos.siteLocations.insertData(data);
      } catch (e) {
        print(e);
        return Response(422);
      }
      return Response.ok(jsonEncode(data.toJson()));
    });

    router.put('/update-site-location/', (Request request) async {
      dynamic input = jsonDecode(await request.readAsString());
      final editH = SiteLocalModel.fromJson(input);
      SiteLocalModel? data = await repos.siteLocations.getFromId(editH.id!);
      if (input['name'] != null) {
        data.name = input['name'];
      }
      if (input['responsable'] != null) {
        data.responsable = input['responsable'];
      }  
      if (input['adresse'] != null) {
        data.adresse = input['adresse'];
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

      repos.siteLocations.update(data);
      return Response.ok(jsonEncode(data.toJson()));
    });

    router.delete('/delete-site-location/<id>', (Request request, String id) async {
      var id = request.params['id'];
      repos.siteLocations.deleteData(int.parse(id!));
      return Response.ok('Supprimée');
    });

    router.all(
      '/<ignored|.*>',
      (Request request) =>
          Response.notFound('La Page siteLocations n\'est pas trouvé'),
    );

    return router;
  }
}
