import 'dart:convert';

import 'package:amcassur/core/env.dart';
import 'package:http/http.dart' as http;
// import 'package:myrawsur/core/env.dart';

class OtpService {
  static Future<String> sendOTP(Map<String, dynamic> payload) async {
    Uri url = Uri.parse(
      '${environement.API['URL_BASE']}' +
          // '${environement.API['URL_BASE_KEYCLOAK_API']}' +
          '${environement.API['SUB_RESSOURCE']['USER']}' +
          '${environement.API['V1']['OTP_REQUEST']}',
    );

    Map<String, String> headers = {'content-type': 'application/json'};
    print('URL send OTP : ${url}');

    http.Response response =
        await http.post(url, headers: headers, body: json.encode(payload));
    print('status send OTP : ${response.statusCode}');
    if (response.statusCode == 204) {
      return 'OFF_SERVICE';
    }

    dynamic data = json.decode(response.body);

    String status = data['status'];
    return status;
  }

  static Future<dynamic> verifyOTP(Map<String, dynamic> payload) async {
    Uri url = Uri.parse(
      // '${environement.API['URL_BASE_KEYCLOAK_API']}' +
      '${environement.API['URL_BASE']}' +
          '${environement.API['SUB_RESSOURCE']['USER']}' +
          '${environement.API['V1']['OTP_VERIFY']}',
    );

    print('URL verify OTP : ${url}');

    Map<String, String> headers = {'content-type': 'application/json'};

    http.Response response =
        await http.post(url, headers: headers, body: json.encode(payload));

    print('status verify OTP ${response.statusCode}');

    dynamic data = json.decode(response.body);

    return data;
  }
}
