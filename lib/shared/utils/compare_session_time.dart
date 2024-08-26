import 'package:amcassur/configs/preference.dart';
import 'package:amcassur/configs/preferencekeys.dart';
import 'package:amcassur/shared/utils/convert_token.dart';

class SessionTime {
  // static bool isSessionValid(DateTime startDate) {
  //   print({
  //     'startDate': startDate,
  //     'currentDate': DateTime.now(),
  //     'diff': DateTime.now().difference(startDate).inMinutes,
  //     'sessionTimes': sessionTimes
  //   });
  //   return DateTime.now().difference(startDate).inMinutes > sessionTimes;
  // }

  static bool isSessionValid() {
    String? token_pref = Preferences.get(PreferenceKeys.TOKEN);
    bool result = ConvertToken.isExpired(token_pref);
    return result;
  }
}
