import 'package:logger/logger.dart' show Logger, PrettyPrinter, DateTimeFormat;

final log = Logger(printer: PrettyPrinter(dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart));
