import 'package:flutter/foundation.dart';

class Logger {
  static void logMsg(dynamic obj, dynamic msg) {
    if (kReleaseMode) {
      return;
    }

    var className = obj.runtimeType.toString();
    className = className == 'String' ? obj as String : className;
    debugPrint('$className msg : $msg', wrapWidth: 2048);
  }

  static void logError(dynamic obj, dynamic msg,
      {StackTrace? stackTrace, bool isFatalError = false}) async {
    if (kReleaseMode) {
      return;
    }

    var str = 'Error : ${msg?.toString()}';
    logMsg(obj, str);
  }
}
