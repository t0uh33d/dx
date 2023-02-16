class Logger {
  static void log(String message,
      {LoggerColor loggerColor = LoggerColor.purple}) {
    // ignore: avoid_print
    print("\x1B[1;36m[DX_ROUTER]\x1B${loggerColor.colorCode} $message \x1B[0m");
  }
}

enum LoggerColor { yellow, purple, green, red }

extension _LoggerColorCode on LoggerColor {
  String get colorCode {
    switch (this) {
      case LoggerColor.yellow:
        return '[0;33m';
      case LoggerColor.purple:
        return '[0;35m';
      case LoggerColor.green:
        return '[0;32m';
      case LoggerColor.red:
        return '[0;31m';
    }
  }
}
