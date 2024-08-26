import 'package:jwt_decode/jwt_decode.dart';

class ConvertToken {
  static Map<String, dynamic>? convert(String? token_pref) {
    if (token_pref != null) {
      if (token_pref != '') {
        return Jwt.parseJwt(token_pref);
      }
    }
    return null;
  }

  static DateTime? getExpiryDate(String? token_pref) {
    if (token_pref != null) {
      if (token_pref != '') {
        return Jwt.getExpiryDate(token_pref);
      }
    }
    return null;
  }

  static bool isExpired(String? token_pref) {
    if (token_pref != null) {
      if (token_pref != '') {
        return Jwt.isExpired(token_pref);
      }
    }
    return true;
  }
}
