import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'core/api/injector.dart';
import 'flavors.dart';

void main() async{
  /// Used to initialize the framework.
  WidgetsFlutterBinding.ensureInitialized();

  ///initialize firebase
  await Firebase.initializeApp();

  /// Initializing the `Injector` class.
  setUpInjection();

  /// Calling the build method of MyApp class.
  F.appFlavor = Flavor.prod;
  runApp(const App());
}
