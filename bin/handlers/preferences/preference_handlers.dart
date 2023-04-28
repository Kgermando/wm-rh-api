import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../models/preferences/preference_model.dart';
import '../../repository/repository.dart';

class PreferenceHandlers {
  final Repository repos;

  PreferenceHandlers(this.repos);

  Router get router {
    final router = Router();

    router.get('/', (Request request) async {
      List<PreferenceModel> data = await repos.preferences.getAllData();
      return Response.ok(jsonEncode(data));
    });

    router.get('/<id>', (Request request, String id) async {
      late PreferenceModel data;
      try {
        data = await repos.preferences.getFromId(int.parse(id));
      } catch (e) {
        print(e);
        return Response(404);
      }
      return Response.ok(jsonEncode(data.toJson()));
    });

    router.post('/insert-preference', (Request request) async {
      var input = jsonDecode(await request.readAsString());

      PreferenceModel data = PreferenceModel(
        companyName: input['companyName'],
        nbrEmploye: input['nbrEmploye'],
        cnss: input['cnss'],
        numeroTaxe: input['numeroTaxe'],
        rccm: input['rccm'],
        idNat: input['idNat'],
        numeroImpot: input['numeroImpot'],
        email: input['email'],
        telephone: input['telephone'],
        adresse: input['adresse'],
        dateDePaie: input['dateDePaie'],
        cnssQPP: input['cnssQPP'],
        inpp: input['inpp'],
        onem: input['onem'],
        cotisationSyndicale: input['cotisationSyndicale'],
        cnssQPO: input['cnssQPO'],
        allocationLogement: input['allocationLogement'],
        allocationTransport: input['allocationTransport'],
        nbrMaxEnfantCourvert: input['nbrMaxEnfantCourvert'],
        allocationFamilliale: input['allocationFamilliale'],
        allocationEpouse: input['allocationEpouse'],
        nbreHeureTravail: input['nbreHeureTravail'],
        tauxDollard: input['tauxDollard'],
        newYear: input['newYear'],
        noel: input['noel'],
        martyrDay: input['martyrDay'],
        kabilaDay: input['kabilaDay'],
        lumumbaDay: input['lumumbaDay'],
        labourDay: input['labourDay'],
        liberationDay: input['liberationDay'],
        indepenceDay: input['indepenceDay'],
        parentDay: input['parentDay'],
        kimbanguDay: input['kimbanguDay'],
        signature: input['signature'],
        created: DateTime.parse(input['created']),
        updateCreated: DateTime.parse(input['updateCreated']),
      );
      try {
        await repos.preferences.insertData(data);
      } catch (e) {
        print(e);
        return Response(422);
      }
      return Response.ok(jsonEncode(data.toJson()));
    });

    router.put('/update-preference/', (Request request) async {
      dynamic input = jsonDecode(await request.readAsString());
      final editH = PreferenceModel.fromJson(input);
      PreferenceModel? data = await repos.preferences.getFromId(editH.id!);

      if (input['companyName'] != null) {
        data.companyName = input['companyName'];
      }
      if (input['nbrEmploye'] != null) {
        data.nbrEmploye = input['nbrEmploye'];
      } 
      if (input['cnss'] != null) {
        data.cnss = input['cnss'];
      }
      if (input['numeroTaxe'] != null) {
        data.numeroTaxe = input['numeroTaxe'];
      }
      if (input['rccm'] != null) {
        data.rccm = input['rccm'];
      }
      if (input['idNat'] != null) {
        data.idNat = input['idNat'];
      } 
      if (input['numeroImpot'] != null) {
        data.numeroImpot = input['numeroImpot'];
      }
      if (input['email'] != null) {
        data.email = input['email'];
      }
      if (input['adresse'] != null) {
        data.adresse = input['adresse'];
      }
      if (input['dateDePaie'] != null) {
        data.dateDePaie = input['dateDePaie'];
      } 
      if (input['cnssQPP'] != null) {
        data.cnssQPP = input['cnssQPP'];
      }
      if (input['inpp'] != null) {
        data.inpp = input['inpp'];
      }
      if (input['onem'] != null) {
        data.onem = input['onem'];
      }
      if (input['cotisationSyndicale'] != null) {
        data.cotisationSyndicale = input['cotisationSyndicale'];
      } 
      if (input['cnssQPO'] != null) {
        data.cnssQPO = input['cnssQPO'];
      }
      if (input['allocationLogement'] != null) {
        data.allocationLogement = input['allocationLogement'];
      }
      if (input['allocationTransport'] != null) {
        data.allocationTransport = input['allocationTransport'];
      }
      if (input['nbrMaxEnfantCourvert'] != null) {
        data.nbrMaxEnfantCourvert = input['nbrMaxEnfantCourvert'];
      } 
      if (input['allocationFamilliale'] != null) {
        data.allocationFamilliale = input['allocationFamilliale'];
      }
      if (input['allocationEpouse'] != null) {
        data.allocationEpouse = input['allocationEpouse'];
      }
      if (input['nbreHeureTravail'] != null) {
        data.nbreHeureTravail = input['nbreHeureTravail'];
      }
      if (input['tauxDollard'] != null) {
        data.tauxDollard = input['tauxDollard'];
      }
      if (input['newYear'] != null) {
        data.newYear = input['newYear'];
      }
      if (input['noel'] != null) {
        data.noel = input['noel'];
      }
      if (input['martyrDay'] != null) {
        data.martyrDay = input['martyrDay'];
      }
      if (input['kabilaDay'] != null) {
        data.kabilaDay = input['kabilaDay'];
      }
      if (input['lumumbaDay'] != null) {
        data.lumumbaDay = input['lumumbaDay'];
      }
      if (input['labourDay'] != null) {
        data.labourDay = input['labourDay'];
      }
      if (input['liberationDay'] != null) {
        data.liberationDay = input['liberationDay'];
      }
      if (input['indepenceDay'] != null) {
        data.indepenceDay = input['indepenceDay'];
      }
      if (input['parentDay'] != null) {
        data.parentDay = input['parentDay'];
      }
      if (input['kimbanguDay'] != null) {
        data.kimbanguDay = input['kimbanguDay'];
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

      repos.preferences.update(data);
      return Response.ok(jsonEncode(data.toJson()));
    });

    router.delete('/delete-preference/<id>',
        (Request request, String id) async {
      var id = request.params['id'];
      repos.preferences.deleteData(int.parse(id!));
      return Response.ok('Supprimée');
    });

    router.all(
      '/<ignored|.*>',
      (Request request) =>
          Response.notFound('La Page preferences n\'est pas trouvé'),
    );

    return router;
  }
}
