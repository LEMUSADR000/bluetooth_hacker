import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:logging/logging.dart' as logging;

final Logger _logger = Logger(
  printer: PrettyPrinter(colors: true, methodCount: 2),
);

final Logger _loggingLogger = Logger(
  printer: PrettyPrinter(colors: true, methodCount: 0),
);

abstract class Log {
  static void init() {
    final DateFormat format = DateFormat('yyyy/MM/dd hh:mmaa');
    logging.Logger.root.level = logging.Level.ALL;
    logging.Logger.root.onRecord.listen((rec) {
      _loggingLogger
          .d('[${rec.level.name}][${format.format(rec.time)}] ${rec.message}');
    });
  }

  static void v(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.v(message, error, stackTrace);
  }

  static void d(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.d(message, error, stackTrace);
  }

  static void i(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.i(message, error, stackTrace);
  }

  static void w(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.w(message, error, stackTrace);
  }

  static void e(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.e(message, error, stackTrace);
  }

  static void wtf(dynamic message, {dynamic error, StackTrace? stackTrace}) {
    _logger.wtf(message, error, stackTrace);
  }
}
