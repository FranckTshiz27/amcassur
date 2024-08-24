import 'dart:async';
import 'dart:convert';

import 'package:amcassur/configs/preference.dart';
import 'package:amcassur/configs/preferencekeys.dart';
import 'package:amcassur/core/env.dart';
import 'package:amcassur/shared/utils/fileUtil.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

class UserService {
  static XFile? passportFile;
  static int statusResponse = 500;
  static Future<bool> updateProfile(XFile file, String username) async {
    Map<String, String> headers = {'Content-Type': 'multipart/form-data'};

    try {
      Uri url = Uri.parse(
        environement.API['URL_BASE'] + environement.API['V1']['UPDATE_PROFILE'],
      );

      print('URL : $url');

      String extention = (p.extension(file.path)).split('.').last;
      print('EXTENSION : ${extention}');
      MediaType mediaType = MediaType("image", extention);
      MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'document',
        file.path,
        contentType: mediaType,
      );

      var request = http.MultipartRequest('POST', url);
      request.fields.addAll({'username': username});
      request.files.add(multipartFile);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      print('STATUS RESPONSE : ${response.statusCode}');

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("CATCH");
      return false;
    }
  }

  static Future<dynamic> updateUser(Map<String, dynamic> dto) async {
    // String token = Preferences.get(PreferenceKeys.TOKEN)!;
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=utf-8',
      // 'Authorization': 'Bearer $token',
    };

    Uri url = Uri.parse(
      environement.API['URL_BASE'] + environement.API['V1']['UPDATE_USER'],
    );
    String body = json.encode(dto);
    print('BODY : ${body}');

    dynamic data;

    try {
      http.Response response = await http
          .post(
            url,
            body: body,
            headers: headers,
          )
          .timeout(Duration(seconds: 10));

      print('BODY : $body');

      dynamic data = response.body;
      print('DATA : $data');
      statusResponse = response.statusCode;
      print('STATUS : $statusResponse');
      return data;
    } on TimeoutException catch (_) {
      // Gestion du timeout
      print('La requête a expiré');
      statusResponse = 500;
      return "Service indisponible. Veuillez contacter le call center pour plus d'informations.";
    } on http.ClientException catch (_) {
      // Gestion des erreurs du client HTTP
      statusResponse = 500;
      return "Une erreur est survenu pendant la requête, ressayer plus tard.";
    } catch (e) {
      // Gestion de toute autre erreur
      print('Erreur: $e');
      statusResponse = 500;
      return "Une erreur est survenu pendant la requête, ressayer plus tard.";
    }
  }

  static Future<dynamic> getProfile(String username) async {
    try {
      Uri url = Uri.parse(
        environement.API['URL_BASE'] +
            environement.API['V1']['GET_PROFILE'] +
            username,
      );
      print('url : $url');
      http.Response response = await http.get(url);
      print('statusCode : ${response.statusCode}');
      if (response.statusCode == 200) {
        // Décoder manuellement la réponse en UTF-8
        String decodedBody = utf8.decode(response.bodyBytes);
        dynamic data = json.decode(decodedBody);
        print(" USER ----------------------------USER--------------------");
        print(data);
        String? base64encode = data['data']['photoProfil'];
        if (base64encode != null) {
          base64encode = base64encode.split(',').last;
          Preferences.set(PreferenceKeys.PROFILE, base64encode);
        }

        String? firstName = data['data']['firstName'];
        if (firstName != null) {
          Preferences.set(PreferenceKeys.F_NAME, firstName);
        }

        String? phone = data['data']['username'];
        if (phone != null) {
          Preferences.set(PreferenceKeys.PHONE_NUMBER, phone);
        }

        String? lastName = data['data']['lastName'];
        if (lastName != null) {
          Preferences.set(PreferenceKeys.L_NAME, lastName);
        }

        String? pName = data['data']['pname'];
        if (pName != null) {
          Preferences.set(PreferenceKeys.P_NAME, pName);
        }

        String? address = data['data']['address'];
        if (address != null) {
          Preferences.set(PreferenceKeys.ADDRESS, address);
        }

        String? dateNaiss = data['data']['dateNaiss'];
        if (dateNaiss != null) {
          Preferences.set(PreferenceKeys.DATE_NAISS, dateNaiss);
        }

        String? lieuNaiss = data['data']['lieuNaiss'];
        if (lieuNaiss != null) {
          Preferences.set(PreferenceKeys.LIEU_NAISS, lieuNaiss);
        }

        String? email = data['data']['email'];
        if (email != null) {
          Preferences.set(PreferenceKeys.EMAIL, email);
        }

        String? code = data['data']['code'];
        if (code != null) {
          Preferences.set(PreferenceKeys.CODE_CLIENT, code);
        }

        String? numDoc = data['data']['numDoc'];
        if (numDoc != null) {
          Preferences.set(PreferenceKeys.NUM_DOC, numDoc);
        }

        String? typeDoc = data['data']['typeDoc'];
        if (typeDoc != null) {
          Preferences.set(PreferenceKeys.TYPE_DOC, typeDoc);
        }

        String? docStr = data['data']['docStr'];
        if (docStr != null) {
          docStr = docStr.split(',').last;
          Preferences.set(PreferenceKeys.DOC, docStr);

          String? typeFile = data['data']['typeFile'];
          if (typeFile != null) {
            Preferences.set(PreferenceKeys.TYPE_FILE, typeFile);
            passportFile = await FileUtil.base64ToXFile(
              base64String: docStr,
              extention: typeFile,
            );
            if (typeDoc == 'passport') {
              String? dateExp = data['data']['dateExp'];

              if (dateExp != null) {
                Preferences.set(
                  PreferenceKeys.DATE_EXPIRATION_PASSEPORT,
                  dateExp,
                );
              }
            }
          }
        }

        print('*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=**==*=*=*=*');
        print('${passportFile?.path}');
        print('*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=**==*=*=*=*');
        print('*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=**==*=*=*=*');
        print('*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=**==*=*=*=*');
        print(numDoc);
        print(lieuNaiss);
        print(dateNaiss);
        print(address);
        print(pName);
        print(lastName);
        print(firstName);
        print(email);

        return data;
      } else {
        return null;
      }
    } catch (e) {
      print("ERREUR $e");
      return null;
    }
  }

  static Future<dynamic> getUserByUsername(String username) async {
    Uri url = Uri.parse(environement.API['URL_BASE'] +
        environement.API['SUB_RESSOURCE']['USER'] +
        environement.API['V1']['FIND_USER_BY_PHONE'] +
        '${environement.KEYCLOAK['REALM']}/' +
        '$username');

    try {
      http.Response response =
          await http.get(url).timeout(Duration(seconds: 10));
      print('statusCode : ${response.statusCode}');
      print(response.body);
      dynamic data = response.body;
      print(data);
      print('DATA : $data');
      statusResponse = response.statusCode;
      return data;
    } on TimeoutException catch (_) {
      // Gestion du timeout
      print('La requête a expiré');
      statusResponse = 500;
      return "Service indisponible. Veuillez contacter le call center pour plus d'informations.";
    } on http.ClientException catch (_) {
      // Gestion des erreurs du client HTTP
      statusResponse = 500;
      return "Une erreur est survenu pendant la requête, ressayer plus tard.";
    } catch (e) {
      // Gestion de toute autre erreur
      print('Erreur: $e');
      statusResponse = 500;
      return "Une erreur est survenu pendant la requête, ressayer plus tard.";
    }
  }
}
