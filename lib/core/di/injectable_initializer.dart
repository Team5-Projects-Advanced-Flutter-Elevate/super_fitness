import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injectable_initializer.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true,
)
Future<void> configureDependencies() async => getIt.init();
