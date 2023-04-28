import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf_io.dart' as shelf_io; 

import 'db/config_db.dart';
import 'handlers/auth/auth_handlers.dart';
import 'handlers/auth/user_handlers.dart';
import 'handlers/mails/mails_handlers.dart';
import 'handlers/notify/mails/mails_notify_handlers.dart';
import 'handlers/performences/performence_handlers.dart';
import 'handlers/performences/performence_note_handlers.dart';
import 'handlers/personnels/personnel_handlers.dart';
import 'handlers/preferences/departement_handlers.dart';
import 'handlers/preferences/fonction_handlers.dart';
import 'handlers/preferences/preference_handlers.dart';
import 'handlers/preferences/site_location_handlers.dart';
import 'handlers/presences/appointement_handlers.dart';
import 'handlers/recrutements/candidature_handlers.dart';
import 'handlers/recrutements/post_handlers.dart';
import 'handlers/settings/monnaie_handlers.dart';
import 'handlers/update/upate_handlers.dart';
import 'middleware/middleware.dart';
import 'repository/repository.dart';

// Configure routes. 
class Service {
  final Repository repos;
  final String serverSecretKey;

  Service(this.repos, this.serverSecretKey);

  Handler get handlers {
    final router = Router();

    // Notify
    router.mount(
        '/api/counts/mails/',
        Pipeline()
            .addMiddleware(setJsonHeader())
            .addMiddleware(handleErrors())
            .addHandler(MailsNotifyHandlers(repos).router));

    // AUTH
    router.mount(
        '/api/auth/',
        Pipeline()
            .addMiddleware(setJsonHeader())
            .addMiddleware(handleErrors())
            .addHandler(AuthHandlers(repos, serverSecretKey).router));
    router.mount(
        '/api/users/',
        Pipeline()
            .addMiddleware(setJsonHeader())
            .addMiddleware(handleErrors())
            // .addMiddleware(handleAuth(serverSecretKey))
            .addHandler(UserHandlers(repos).router));


    // RH
    router.mount(
      '/api/rh/personnels/',
      Pipeline()
          .addMiddleware(setJsonHeader())
          .addMiddleware(handleErrors())
          // .addMiddleware(handleAuth(serverSecretKey))
          .addHandler(PersonnelHandlers(repos).router));

    router.mount(
      '/api/rh/performences/',
      Pipeline()
          .addMiddleware(setJsonHeader())
          .addMiddleware(handleErrors())
          // .addMiddleware(handleAuth(serverSecretKey))
          .addHandler(PerformenceHandlers(repos).router));
    router.mount(
      '/api/rh/performences/notes/',
      Pipeline()
          .addMiddleware(setJsonHeader())
          .addMiddleware(handleErrors())
          // .addMiddleware(handleAuth(serverSecretKey))
          .addHandler(PerformenceNoteHandlers(repos).router));

    router.mount(
      '/api/rh/preferences/',
      Pipeline()
          .addMiddleware(setJsonHeader())
          .addMiddleware(handleErrors())
          // .addMiddleware(handleAuth(serverSecretKey))
          .addHandler(PreferenceHandlers(repos).router));
    router.mount(
      '/api/rh/preferences/departements/',
      Pipeline()
          .addMiddleware(setJsonHeader())
          .addMiddleware(handleErrors())
          // .addMiddleware(handleAuth(serverSecretKey))
          .addHandler(DepartementHandlers(repos).router));
    router.mount(
      '/api/rh/preferences/fonctions/',
      Pipeline()
          .addMiddleware(setJsonHeader())
          .addMiddleware(handleErrors())
          // .addMiddleware(handleAuth(serverSecretKey))
          .addHandler(FonctionHandlers(repos).router));
    router.mount(
      '/api/rh/preferences/site-locations/',
      Pipeline()
          .addMiddleware(setJsonHeader())
          .addMiddleware(handleErrors())
          // .addMiddleware(handleAuth(serverSecretKey))
          .addHandler(SiteLocationHandlers(repos).router));


    router.mount(
      '/api/rh/presences/apointements/',
      Pipeline()
          .addMiddleware(setJsonHeader())
          .addMiddleware(handleErrors())
          // .addMiddleware(handleAuth(serverSecretKey))
          .addHandler(ApointementHandlers(repos).router));


    router.mount(
      '/api/rh/recrutements/candidatures/',
      Pipeline()
          .addMiddleware(setJsonHeader())
          .addMiddleware(handleErrors())
          // .addMiddleware(handleAuth(serverSecretKey))
          .addHandler(CandidatureHandlers(repos).router));
    router.mount(
      '/api/rh/recrutements/posts/',
      Pipeline()
          .addMiddleware(setJsonHeader())
          .addMiddleware(handleErrors())
          // .addMiddleware(handleAuth(serverSecretKey))
          .addHandler(PostHandlers(repos).router));

    

    // MAILLING
    router.mount(
        '/api/mails/',
        Pipeline()
            .addMiddleware(setJsonHeader())
            .addMiddleware(handleErrors())
            // .addMiddleware(handleAuth(serverSecretKey))
            .addHandler(MailsHandlers(repos).router));

    // UPDATE
    router.mount(
        '/api/update-versions/',
        Pipeline()
            .addMiddleware(setJsonHeader())
            .addMiddleware(handleErrors())
            // .addMiddleware(handleAuth(serverSecretKey))
            .addHandler(UpdateHandlers(repos).router));

    // Settings
    router.mount(
        '/api/settings/monnaies/',
        Pipeline()
            .addMiddleware(setJsonHeader())
            .addMiddleware(handleErrors())
            // .addMiddleware(handleAuth(serverSecretKey))
            .addHandler(MonnaieHandlers(repos).router));

    router.all(
      '/<ignored|.*>',
      (Request request) => Response.notFound(null),
    );
    return router;
  }
}

void main(List<String> args) async {
  final ip = "app";
  final port = 80;

  PostgreSQLConnection connection = await ConnexionDatabase().connection();
  print("Database it's work...");

  await connection.open();
  Repository repos = Repository(connection);
  Service service = Service(repos, "work_management_Key");

  final server = await shelf_io.serve(service.handlers, ip, port);

  print('Server listening on port ${server.port}');
}
