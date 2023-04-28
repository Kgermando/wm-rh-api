import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../models/personnels/personel_model.dart';
import '../../repository/repository.dart';

class PersonnelHandlers {
  final Repository repos;

  PersonnelHandlers(this.repos);

  Router get router {
    final router = Router();

    router.get('/', (Request request) async {
      List<PersonnelModel> data = await repos.personnels.getAllData();
      return Response.ok(jsonEncode(data));
    });

    router.get('/<id>', (Request request, String id) async {
      late PersonnelModel data;
      try {
        data = await repos.personnels.getFromId(int.parse(id));
      } catch (e) {
        print(e);
        return Response(404);
      }
      return Response.ok(jsonEncode(data.toJson()));
    });

    router.post('/insert-personnel', (Request request) async {
      var input = jsonDecode(await request.readAsString());

      PersonnelModel data = PersonnelModel(
        photo: input['photo'],
        nom: input['nom'],
        postnom: input['postnom'],
        prenom: input['prenom'],
        email: input['email'],
        telephone: input['telephone'],
        adresse: input['adresse'],
        sexe: input['sexe'],
        dateNaissance: DateTime.parse(input['dateNaissance']),
        lieuNaissance: input['lieuNaissance'],
        nationalite: input['lieuNaissance'],
        etatCivile: input['etatCivile'],
        nbrEnfant: input['nbrEnfant'],
        nbrDependants: input['nbrDependants'],
        nbrDependantsMax: input['nbrDependantsMax'],
        matricule: input['matricule'],
        numeroCNSS: input['numeroCNSS'],
        role: input['role'],
        departement: input['departement'],
        title: input['title'],
        fonction: input['fonction'],
        services: input['services'],
        siteLocation: input['siteLocation'],
        typeContrat: input['typeContrat'],
        dateDebutContrat: DateTime.parse(input['dateDebutContrat']),
        dateFinContrat: DateTime.parse(input['dateFinContrat']),
        salaire: input['salaire'],
        compteBancaire: input['compteBancaire'],
        nomBanque: input['nomBanque'],
        fraisBancaire: input['fraisBancaire'],
        statutPersonnel: input['statutPersonnel'],
        cvUrl: input['cvUrl'],
        signature: input['signature'],
        created: DateTime.parse(input['created']),
        updateCreated: DateTime.parse(input['updateCreated']),
        isDelete: input['isDelete'],
      );
      try {
        await repos.personnels.insertData(data);
      } catch (e) {
        print(e);
        return Response(422);
      }
      return Response.ok(jsonEncode(data.toJson()));
    });

    router.put('/update-personnel/', (Request request) async {
      dynamic input = jsonDecode(await request.readAsString());
      final editH = PersonnelModel.fromJson(input);
      PersonnelModel? data = await repos.personnels.getFromId(editH.id!);

      if (input['photo'] != null) {
        data.photo = input['photo'];
      }
      if (input['nom'] != null) {
        data.nom = input['nom'];
      }
      if (input['postnom'] != null) {
        data.postnom = input['postnom'];
      }
      if (input['prenom'] != null) {
        data.prenom = input['prenom'];
      }
      if (input['email'] != null) {
        data.email = input['email'];
      }
      if (input['telephone'] != null) {
        data.telephone = input['telephone'];
      }
      if (input['adresse'] != null) {
        data.adresse = input['adresse'];
      }
      if (input['sexe'] != null) {
        data.sexe = input['sexe'];
      }
      if (input['dateNaissance'] != null) {
        data.dateNaissance = DateTime.parse(input['dateNaissance']);
      }
      if (input['lieuNaissance'] != null) {
        data.lieuNaissance = input['lieuNaissance'];
      }
      if (input['nationalite'] != null) {
        data.nationalite = input['nationalite'];
      }
      if (input['etatCivile'] != null) {
        data.etatCivile = input['etatCivile'];
      }
      if (input['nbrEnfant'] != null) {
        data.nbrEnfant = input['nbrEnfant'];
      }if (input['nbrDependants'] != null) {
        data.nbrDependants = input['nbrDependants'];
      }
      if (input['nbrDependantsMax'] != null) {
        data.nbrDependantsMax = input['nbrDependantsMax'];
      }
      if (input['matricule'] != null) {
        data.matricule = input['matricule'];
      }
      if (input['numeroCNSS'] != null) {
        data.numeroCNSS = input['numeroCNSS'];
      }
      if (input['role'] != null) {
        data.role = input['role'];
      }
      if (input['departement'] != null) {
        data.departement = input['departement'];
      }
      if (input['title'] != null) {
        data.title = input['title'];
      }
      if (input['fonction'] != null) {
        data.fonction = input['fonction'];
      }
      if (input['siteLocation'] != null) {
        data.siteLocation = input['siteLocation'];
      }
      if (input['typeContrat'] != null) {
        data.typeContrat = input['typeContrat'];
      }
      if (input['salaire'] != null) {
        data.salaire = input['salaire'];
      }
      if (input['compteBancaire'] != null) {
        data.compteBancaire = input['compteBancaire'];
      }
      if (input['nomBanque'] != null) {
        data.nomBanque = input['nomBanque'];
      }
      if (input['fraisBancaire'] != null) {
        data.fraisBancaire = input['fraisBancaire'];
      }
      if (input['statutPersonnel'] != null) {
        data.statutPersonnel = input['statutPersonnel'];
      }
      if (input['cvUrl'] != null) {
        data.cvUrl = input['cvUrl'];
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
      if (input['isDelete'] != null) {
        data.isDelete = input['isDelete'];
      }
      repos.personnels.update(data);
      return Response.ok(jsonEncode(data.toJson()));
    });

    router.delete('/delete-personnel/<id>', (Request request, String id) async {
      var id = request.params['id'];
      repos.personnels.deleteData(int.parse(id!));
      return Response.ok('Supprimée');
    });

    router.all(
      '/<ignored|.*>',
      (Request request) =>
          Response.notFound('La Page personnels n\'est pas trouvé'),
    );

    return router;
  }
}
