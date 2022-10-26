import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_production_boilerplate/global_providers.dart';
import 'package:flutter_production_boilerplate/ui/screens/control_screen.dart';
import 'package:flutter_production_boilerplate/ui/screens/main_screen.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:routemaster/routemaster.dart';

import 'config/theme.dart';

/// Try using const constructors as much as possible!

void main() async {
  /// Initialize packages
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  if (Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }
  final Directory tmpDir = await getTemporaryDirectory();
  Hive.init(tmpDir.toString());
  final HydratedStorage storage = await HydratedStorage.build(
    storageDirectory: tmpDir,
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(
      EasyLocalization(
        path: 'assets/translations',
        supportedLocales: const <Locale>[
          Locale('en'),
        ],
        fallbackLocale: const Locale('en'),
        useFallbackTranslations: true,
        child: GlobalProviders(),
      ),
    ),
    storage: storage,
  );
}

final RouteMap routeMap = RouteMap(
  routes: {
    '/': (RouteData route) => const MaterialPage<dynamic>(child: MainScreen()),
    ControlScreen.route: (RouteData route) =>
        const MaterialPage<dynamic>(child: ControlScreen()),
  },
  onUnknownRoute: (_) => const Redirect('/'),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter controller app for Arduino car',
      routerDelegate: RoutemasterDelegate(routesBuilder: (_) => routeMap),
      routeInformationParser: const RoutemasterParser(),
      theme: darkTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
    );
  }
}
