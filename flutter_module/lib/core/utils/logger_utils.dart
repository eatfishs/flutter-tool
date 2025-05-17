
/// @author: jiangjunhui
/// @date: 2024/12/30
enum LogLevel { info, warn, error, debug }
class Logger {
 static const Map<LogLevel, String> _levelColors = {
  /*
    32 Green
    33 Yellow
    31 Red
    34 Blue
    36 青色
     */
  LogLevel.info: '\x1B[33m',  // 青色
  LogLevel.warn: '\x1B[35m',  // 紫色
  LogLevel.error: '\x1B[31m', // Red
  LogLevel.debug: '\x1B[34m', // Blue
 };

 static const String _resetColor = '\x1B[0m';



}
