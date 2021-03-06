import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class Utils {
  //todo: customise
  static showErrorDialog(String message, bool cancelable) {
    EasyLoading.instance..displayDuration = const Duration(milliseconds: 2000);
    EasyLoading.showError(message, dismissOnTap: cancelable);
  }

  static showInfoDialog(String message, bool cancelable) {
    EasyLoading.instance..dismissOnTap = cancelable ?? false;
    EasyLoading.showInfo(message);
  }

  static getFormattedTime(int time) {
    String formattedTime =
        DateFormat("h:mma").format(DateTime.fromMicrosecondsSinceEpoch(time));
    print("Time sent ${formattedTime}");
    return formattedTime;
  }
}
