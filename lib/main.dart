import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rent_car_app/core/routes.dart';
import 'package:rent_car_app/firebase_options.dart';
import 'package:rent_car_app/theme/theme.dart';
import 'package:sizer/sizer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() async{
  initDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}
final talker = TalkerFlutter.init();
void initSingletons(){

}
void initDependencies(){

  GetIt.I.registerSingleton<Talker>(talker);
  final talkerDioLogger = TalkerDioLogger(
    talker: talker
  );
  final dio = Dio();
  dio.interceptors.add(talkerDioLogger);
  talker.info('App Started');
  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printCreations: true,
      printClosings: true,
      printStateFullData: true,
      printChanges: true,
      printEventFullData: true
    )
  );

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
        theme: theme,
        debugShowCheckedModeBanner: false,
        routerConfig: _appRouter.config(
          navigatorObservers: () =>  [TalkerRouteObserver(GetIt.I<Talker>())]
        ),
      );
      },
    );
  }
}