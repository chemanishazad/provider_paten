import 'package:flutter/material.dart';
import 'package:provider_paten/core/route/routes.dart';
import 'package:provider_paten/core/theme/theme.dart';
import 'package:provider_paten/core/theme/theme_provider.dart';
import 'package:provider_paten/provider/authProvider/authProvider.dart';
import 'package:provider_paten/provider/homeProvider/homeProvider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('fr'),
        Locale('de'),
        Locale('ta'),
      ],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => HomeProvider()),
          ],
          child: Consumer2<ThemeProvider, AuthProvider>(
            builder: (context, themeProvider, userProvider, child) {
              return MaterialApp.router(
                title: 'Flutter Demo',
                themeMode: themeProvider.themeMode,
                theme: lightTheme,
                darkTheme: darkTheme,
                routerConfig: router,
                locale: context.locale,
                supportedLocales: context.supportedLocales,
                localizationsDelegates: context.localizationDelegates,
              );
            },
          ),
        );
      },
    );
  }
}
