import 'package:get_it/get_it.dart';

import '../../../../../core/api/api_client.dart';
import '../../../../../core/api/client_setup.dart';

GetIt getIt = GetIt.instance;

/// It sets up the injection of the `` service into the `` of the controller
setUpInjection() {
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(setUpApiClient()));
  // getIt.registerLazySingleton<SharedPrefs>(() => SharedPrefs());



}

