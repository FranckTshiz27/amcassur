import 'dart:async';
import 'dart:convert';

import 'package:amcassur/configs/preference.dart';
import 'package:amcassur/configs/preferencekeys.dart';
import 'package:amcassur/core/env.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static void logout() async {
    // UserService.passportFile = null;
    await Preferences.set(PreferenceKeys.TOKEN, '');
    await Preferences.set(PreferenceKeys.PHONE_NUMBER, '');
    await Preferences.set(PreferenceKeys.PREFIX_COUNTRY, '');
    await Preferences.set(PreferenceKeys.PASSWORD, '');
    await Preferences.set(PreferenceKeys.PHONE_CALL_CENTER, '');
    await Preferences.set(PreferenceKeys.DATE_NAISS, '');
    await Preferences.set(PreferenceKeys.P_NAME, '');
    await Preferences.set(PreferenceKeys.F_NAME, '');
    await Preferences.set(PreferenceKeys.LIEU_NAISS, '');
    await Preferences.set(PreferenceKeys.L_NAME, '');
    await Preferences.set(PreferenceKeys.ADDRESS, '');
    await Preferences.set(PreferenceKeys.EMAIL, '');
    await Preferences.set(PreferenceKeys.TYPE_DOC, '');
    await Preferences.set(PreferenceKeys.DOC, '');
    await Preferences.set(PreferenceKeys.TYPE_FILE, '');
    await Preferences.set(PreferenceKeys.PERSMORAL, '');
    await Preferences.set(PreferenceKeys.DATE_EXPIRATION_PASSEPORT, '');
    await Preferences.set(PreferenceKeys.CODE_CLIENT, '');
  }

  static Future<String> login(String phone, String password) async {
    Uri url = Uri.parse(
      '${environement.KEYCLOAK['KEYCLOAK_URL']}' +
          '${environement.KEYCLOAK['SSO_URL']}',
    );

    print('URL : $url');

    Map<String, String> headers = {
      'content-type': 'application/x-www-form-urlencoded',
      'cache-control': 'no-cache',
    };

    Map<String, String> data = {
      'client_id': environement.KEYCLOAK['CLIENT_ID']!,
      'username': phone,
      'password': password,
      'grant_type': 'password'
    };

    try {
      http.Response response = await http
          .post(url, headers: headers, body: data)
          .timeout(const Duration(seconds: 30));

      print(response.body);

      if (response.statusCode == 200) {
        dynamic token = json.decode(response.body);
        await Preferences.set(PreferenceKeys.TOKEN, token['access_token']);
        await Preferences.set(PreferenceKeys.PASSWORD, password);
        return "SUCCESS";
      } else if (response.statusCode == 400) {
        return "DESABLE_ACCOUNT";
      } else if (response.statusCode == 401) {
        return "UNAUTHORIZED";
      } else {
        return "ERROR";
      }
    } on TimeoutException catch (e) {
      print('Timeout');
      print('Error: $e');
      return "TIMEOUT";
    } on Error catch (e) {
      print('Error: $e');
      return "ERROR";
    }
  }

  static Future<String> register(Map<String, dynamic> payload) async {
    Uri url = Uri.parse(
      '${environement.API['URL_BASE']}' +
          '${environement.API['SUB_RESSOURCE']['USER']}' +
          '${environement.API['V1']['CREATE_USER']}',
    );
    print(" URRRRRRRRRRRRRRRRRRRRRRRRLLLLLLLLLLLLLLL ");
    print(url);
    String body = json.encode(payload);
    Map<String, String> headers = {
      'content-type': 'application/json',
      'cache-control': 'no-cache',
    };

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print('status register : ${response.statusCode}');

    dynamic data = json.decode(response.body);

    print('data response : ${response}');

    String status = data['status'];
    return status;
  }

  static Future<String> resetPassword(Map<String, dynamic> payload) async {
    Uri url = Uri.parse(
      '${environement.API['URL_BASE']}' +
          '${environement.API['SUB_RESSOURCE']['USER']}' +
          '${environement.API['V1']['CHANGE_PASSWORD_USER']}',
    );

    print(url);

    json.encode(payload);
    Map<String, String> headers = {
      'content-type': 'application/json',
      'cache-control': 'no-cache',
    };

    http.Response response =
        await http.post(url, headers: headers, body: json.encode(payload));

    if (response.statusCode == 204) {
      return "SUCCESS";
    } else if (response.statusCode == 404) {
      return "USERNAME_NOT_EXIST";
    } else {
      dynamic data = json.decode(response.body);
      String status = data['status'];
      return status;
    }
  }
}
