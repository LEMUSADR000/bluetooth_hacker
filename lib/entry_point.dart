import 'dart:async';

import 'package:bluetooth_hacker/app/application.dart';
import 'package:bluetooth_hacker/app/bloc_observer.dart';
import 'package:bluetooth_hacker/di/di.dart';
import 'package:bluetooth_hacker/utils/log.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class EntryPoint {
  static Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Disables landscape mode
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    runZonedGuarded(
      () async {
        getIt.init();
        await getIt.allReady(timeout: const Duration(seconds: 10));

        return BlocOverrides.runZoned(
          () => runApp(const Application()),
          blocObserver: AppBlocObserver(),
        );

        // if (config.production && config.sentry != null && !kDebugMode) {
        //   await SentryFlutter.init(
        //     (options) {
        //       options
        //         ..dsn = config.sentry
        //         ..environment = config.env
        //         ..release = 'v${getIt<DeviceInfo>().appVersion}'
        //         // TODO(Adrian): Figure out what trace sample we should use
        //         ..tracesSampleRate = 1.0
        //         ..beforeSend = _sentryExtrasProcessor;
        //     },
        //     appRunner: appRunnerCallback,
        //   );
        // } else {
        //   Log.d('Sentry was not initialized. Production: ${config.production}');
        //   appRunnerCallback();
        // }
      },
      (error, stackTrace) {
        Log.e('Uncaught dart exception', error: error, stackTrace: stackTrace);
      },
    );

    FlutterError.onError = (details) async {
      // await Sentry.captureException(
      //   details.exception,
      //   stackTrace: details.stack,
      // );
      Log.e(
        'Uncaught flutter exception',
        error: details.exception,
        stackTrace: details.stack,
      );
    };
  }

  // static FutureOr<SentryEvent?> _sentryExtrasProcessor(
  //   SentryEvent event, {
  //   dynamic hint,
  // }) async {
  //   return event.copyWith(
  //     user: SentryUser(
  //       username: getIt<MeRepository>().me?.fullName,
  //       email: getIt<MeRepository>().me?.email,
  //     ),
  //     extra: {
  //       'selectedFacility': getIt<MeRepository>().selectedFacility?.id,
  //       'selectedMemberShip': getIt<MeRepository>().currentMembership,
  //     },
  //   );
  // }
}
