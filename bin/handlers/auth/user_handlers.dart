import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';

import '../../models/users/user_model.dart';
import '../../repository/repository.dart';

class UserHandlers {
  final Repository repos;
  UserHandlers(this.repos);

  Router get router {
    final router = Router();

    // router.get('/users/', (Request request) async {
    //   List<UserModel> data = await repos.users.getAllData();
    //   return Response.ok(jsonEncode(data));
    // });

    // Get all users
    router.get('/', (Request request) async {
      List<UserModel> data = await repos.users.getAllData();
      return Response.ok(jsonEncode(data));
    });

    router.get('/user/', (Request request) async {
      UserModel selectUser =
          await repos.users.getFromId(request.context['id'] as int);
      return Response.ok(jsonEncode(selectUser.toJson()));
    });

    router.get('/<id>', (Request request, String id) async {
      late UserModel selectUser;
      try {
        selectUser = await repos.users.getFromId(int.parse(id));
      } catch (e) {
        print(e);
        return Response(404);
      }
      return Response.ok(jsonEncode(selectUser.toJson()));
    });

    // Add new user
    router.post('/insert-user', (Request request) async {
      var input = jsonDecode(await request.readAsString());
      UserModel agent = UserModel(
        photo: input['photo'],
        nom: input['nom'],
        postnom: input['postnom'],
        prenom: input['prenom'],
        email: input['email'],
        telephone: input['telephone'],
        adresse: input['adresse'],
        sexe: input['sexe'],
        nationalite: input['nationalite'],
        etatCivile: input['etatCivile'],
        matricule: input['matricule'],
        numeroCNSS: input['numeroCNSS'],
        role: input['role'],
        departement: input['departement'],
        title: input['title'],
        fonction: input['fonction'],
        services: input['services'],
        siteLocation: input['siteLocation'],
        signature: input['signature'],
        created: DateTime.parse(input['created']),
        updateCreated: DateTime.parse(input['updateCreated']),
        passwordHash:
            md5.convert(utf8.encode(input['passwordHash'])).toString(),
      );
      try {
        await repos.users.insertData(agent);
      } catch (e) {
        print(e);
        return Response(422);
      }
      return Response.ok(jsonEncode(agent.toJson()));
    });


    router.put('/update-user/', (Request request) async {
      dynamic input = jsonDecode(await request.readAsString());
      final editH = UserModel.fromJson(input);
      UserModel? selectUser = await repos.users.getFromId(editH.id!);

      if (input['photo'] != null) {
        selectUser.photo = input['photo'];
      }
      if (input['nom'] != null) {
        selectUser.nom = input['nom'];
      }
      if (input['postnom'] != null) {
        selectUser.postnom = input['postnom'];
      }
      if (input['prenom'] != null) {
        selectUser.prenom = input['prenom'];
      }
      if (input['email'] != null) {
        selectUser.email = input['email'];
      }
      if (input['telephone'] != null) {
        selectUser.telephone = input['telephone'];
      }
      if (input['adresse'] != null) {
        selectUser.adresse = input['adresse'];
      }
      if (input['sexe'] != null) {
        selectUser.sexe = input['sexe'];
      }
      if (input['nationalite'] != null) {
        selectUser.nationalite = input['nationalite'];
      }
      if (input['etatCivile'] != null) {
        selectUser.etatCivile = input['etatCivile'];
      }
      if (input['matricule'] != null) {
        selectUser.matricule = input['matricule'];
      }
      if (input['numeroCNSS'] != null) {
        selectUser.numeroCNSS = input['numeroCNSS'];
      }
      if (input['role'] != null) {
        selectUser.role = input['role'];
      }
      if (input['departement'] != null) {
        selectUser.departement = input['departement'];
      }if (input['title'] != null) {
        selectUser.title = input['title'];
      }
      if (input['fonction'] != null) {
        selectUser.fonction = input['fonction'];
      }
      if (input['services'] != null) {
        selectUser.services = input['services'];
      }
      if (input['siteLocation'] != null) {
        selectUser.siteLocation = input['siteLocation'];
      }
      if (input['signature'] != null) {
        selectUser.signature = input['signature'];
      }
      if (input['created'] != null) {
        selectUser.created = DateTime.parse(input['created']);
      }
      if (input['updateCreated'] != null) {
        selectUser.updateCreated = DateTime.parse(input['updateCreated']);
      }
      repos.users.update(selectUser);
      return Response.ok(jsonEncode(selectUser.toJson()));
    });

    router.put('/change-password/', (Request request) async {
      dynamic input = jsonDecode(await request.readAsString());
      final editH = UserModel.fromJson(input);
      UserModel? selectUser = await repos.users.getFromId(editH.id!);

      // Check si le mot de passe par defaut est correct
      if (input['passwordHash'] != null) {
        selectUser.passwordHash =
            md5.convert(utf8.encode(input['passwordHash'])).toString();
      }
      repos.users.update(selectUser);
      return Response.ok(jsonEncode(selectUser.toJson()));
    });

    router.delete('/delete-user/<id>', (Request request, String id) async {
      var id = request.params['id'];
      repos.users.deleteData(int.parse(id!));
      return Response.ok('Agent supprimée');
    });

    router.all(
      '/<ignored|.*>',
      (Request request) => Response.notFound('La Page users n\'est pas trouvé'),
    );

    return router;
  }
}
