import 'package:postgres/postgres.dart';

import 'mails/mail_repository.dart';
import 'notify/mails/mails_notify_repository.dart';
import 'performences/performence_note_repository.dart';
import 'performences/performence_repository.dart';
import 'personnels/personnel_repository.dart';
import 'preferences/departement_repository.dart';
import 'preferences/fonction_repository.dart';
import 'preferences/preference_repository.dart';
import 'preferences/site_location_repository.dart';
import 'presences/apointement_repository.dart';
import 'recrutements/candidature_repository.dart';
import 'recrutements/post_repository.dart';
import 'settings/monnaie_repository.dart';
import 'update/update_version_repository.dart';
import 'user/refresh_token_repository.dart';
import 'user/user_repository.dart';

class Repository {
  final PostgreSQLConnection executor;
  late RefreshTokensRepository refreshTokens;
  late UserRepository users;

  // Settings
  late MonnaieRepository monnaies;

  // RH
  late PerformenceRepository performences;
  late PerformenceNoteRepository performencesNote;
  late PersonnelRepository personnels;

  // Preferences
  late DepartementRepository departements;
  late FonctionRepository fonctions;
  late PreferenceRepository preferences;
  late SiteLocationRepository siteLocations;

  // Presences
  late ApointementRepository apointements;

  // Recrutements
  late CandidatureRepository candidatures;
  late PostRepository posts;

  // Mails
  late MailRepository mails;

  // Update version
  late UpdateVersionRepository updateVersion;

  // Notify Count
  late MailsNotifyRepository mailsNotifyCount;

  Repository(this.executor) {
    // Notification SideBar

    mailsNotifyCount = MailsNotifyRepository(executor, 'mails');

    // Settings
    monnaies = MonnaieRepository(executor, 'monnaies');

    // AUTH
    refreshTokens = RefreshTokensRepository(executor, 'refresh_tokens');
    users = UserRepository(executor, 'users');

    // RH
    performences = PerformenceRepository(executor, 'performences');
    performencesNote = PerformenceNoteRepository(executor, 'performences_note');
    personnels = PersonnelRepository(executor, 'personnels');

    // Preferences
    departements = DepartementRepository(executor, 'departements');
    fonctions = FonctionRepository(executor, 'fonctions');
    preferences = PreferenceRepository(executor, 'preferences');
    siteLocations = SiteLocationRepository(executor, 'site_locations');

    // Presences
    apointements = ApointementRepository(executor, 'apointements');

    // Recrutements
    candidatures = CandidatureRepository(executor, 'candidatures');
    posts = PostRepository(executor, 'posts');

    // Mails
    mails = MailRepository(executor, 'mails');
    // Update Version
    updateVersion = UpdateVersionRepository(executor, 'update_versions');
  }
}
