import 'package:simple_logger/simple_logger.dart';

final logger = SimpleLogger()
  ..setLevel(
    Level.INFO,
    // Level.WARNING,
    includeCallerInfo: false,
  );
