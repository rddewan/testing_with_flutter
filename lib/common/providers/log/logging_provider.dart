

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

/// Provider logger available only in debug mode
final loggingProvider = Provider<SetupLogger>((ref) {  
  return SetupLogger();
});

class SetupLogger {  
  SetupLogger();

  /// Enable logging only in debug mode
  Future<void> init() async {

    // check for debug or release mode
    if (kDebugMode) {

      Logger.root.level = Level.ALL; 
      Logger.root.onRecord.listen((record) {   
        
        // if the log level is severe then send the log to firebase crash analytics
        // you can add other condition to check the log level
        
        if (record.level == Level.SEVERE){          
          debugPrint('${record.level.name}: ${record.time}: ${record.message} : ${record.error} : : ${record.stackTrace}');
        }
        else if (record.level == Level.INFO){    
          debugPrint('${record.level.name}: ${record.loggerName}: (message): ${record.message}');
        }
        else {
          debugPrint('${record.level.name}: ${record.loggerName}: ${record.time}: ${record.message}');
        }
      });

    } 
    else {
      // Disable logging in release mode
      Logger.root.level = Level.OFF;
    } 

  }
}

