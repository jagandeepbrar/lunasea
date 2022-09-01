import 'package:lunasea/system/environment.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class LunaSentry {
  Future<void> initialize() async {
    await SentryFlutter.init((options) {
      options.dsn = LunaEnvironment.sentryDSN;
      options.environment = LunaEnvironment.flavor;
      options.release = LunaEnvironment.commit;
    });
  }

  Future<void> captureException(dynamic error, StackTrace? stackTrace) async {
    await Sentry.captureException(error, stackTrace: stackTrace);
  }

  SentryNavigatorObserver get navigatorObserver => SentryNavigatorObserver();
}
