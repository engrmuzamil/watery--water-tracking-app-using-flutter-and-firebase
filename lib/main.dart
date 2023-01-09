import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// providers
import './providers/home_provider.dart';
import './providers/auth_provider.dart';
import './providers/statistics_provider.dart';

// screens
import './root.dart';
import './screens/data_entry_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]);

  // FlutterLocalNotificationsPlugin notificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  // InitializationSettings settings = InitializationSettings();
  // await notificationsPlugin?.initialize(
  //   settings,
  // );
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('notification_icon');
  final MacOSInitializationSettings initializationSettingsMacOS =
      MacOSInitializationSettings();
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      macOS: initializationSettingsMacOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, HomeProvider>(
          create: (context) => HomeProvider(),
          update: (context, authProvider, homeProvider) =>
              homeProvider!..update(authProvider.user),
        ),
        ChangeNotifierProxyProvider<AuthProvider, StatisticsProvider>(
          create: (context) => StatisticsProvider(),
          update: (context, authProvider, statisticsProvider) =>
              statisticsProvider!..update(authProvider.user),
        )
      ],
      child: MaterialApp(
        //showPerformanceOverlay: true,
        title: 'Drinkable',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder()
          }),
        ),
        home: Root(),
        routes: {
          DataEntryScreen.routeName: (ctx) => DataEntryScreen(),
        },
      ),
    );
  }
}
