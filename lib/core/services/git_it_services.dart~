import 'package:fruits/core/services/database_services.dart';
import 'package:fruits/core/services/firestore_database_services.dart';
import 'package:fruits/features/auth/data/repos/auth_repo_impl.dart';
import 'package:fruits/features/auth/domain/repos/auth_repo.dart';
import 'package:get_it/get_it.dart';

import 'firebase_auth_services.dart';

final GetIt getIt = GetIt.instance;

void setupGitIt() {
  getIt.registerSingleton<FirebaseAuthServices>(FirebaseAuthServices());
  getIt.registerSingleton<DatabaseServices>(FireStoreDatabaseServices());
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(firebaseAuthServices: getIt<FirebaseAuthServices>(),databaseServices: getIt<DatabaseServices>()));
}