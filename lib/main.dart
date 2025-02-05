import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plugilo/core/common/cubit/app_cubit_observer.dart';
import 'package:plugilo/core/common/cubit/auth_cubit.dart';
import 'package:plugilo/core/common/event_hub/event_hub.dart';
import 'package:plugilo/core/config/constants.dart';
import 'package:plugilo/core/di/injection.dart';
import 'package:plugilo/core/router/app_router.dart';
import 'package:plugilo/core/theme/theme.dart';
import 'package:plugilo/core/utils/notification_helper.dart';
import 'package:plugilo/data/repo/firebase_message_repository.dart';
import 'package:plugilo/generated/assets.gen.dart';

void main() async {
  await _configApp();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => serviceLocator<AuthCubit>(),
        ),
      ],
      child: EasyLocalization(
        supportedLocales: const [
          Locale('vi'),
          Locale('en'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('vi'),
        saveLocale: true,
        startLocale: const Locale('vi'),
        child: const ScreenUtilInit(
          designSize: Size(390, 844),
          child: MainApp(),
        ),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}

Future<void> _configApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // i10n
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableBuildModes = [];
  // firebase
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // crashlytics
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };
  // env
  await dotenv.load(fileName: Assets.env.aEnvProd);
  // path
  // usePathUrlStrategy();
  // state observer
  if (!kReleaseMode) {
    runStateObserver();
  }
  // dependency injection
  configureDependencies();
  // notification
  Future.delayed(const Duration(seconds: 3), () => handleNotification());

  HttpOverrides.global = MyHttpOverrides();
}

handleNotification() {
  LocalNotification().initialize(onDidReceiveNotificationResponse);

  serviceLocator<FirebaseMessageRepository>().onMessage((message) {
    globalEventHub.fire(EventBusType.reloadUnreadMessage.value);
    if (message != null && Platform.isAndroid) {
      LocalNotification().showNotification(message);
    }
  });

  serviceLocator<FirebaseMessageRepository>().onMessageOpenedApp((message) {
    globalEventHub.fire(EventBusType.reloadUnreadMessage.value);
    log(message.notification?.toString() ?? "");
  });
}

void onDidReceiveNotificationResponse(NotificationResponse details) {
  log(details.toString());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

/*
  # localization
  dart run easy_localization:generate -f keys --source-dir assets/translations --output-file locale_keys.g.dart --output-dir lib/generated
  # assets & injectable
  dart run build_runner build --delete-conflicting-outputs
*/
