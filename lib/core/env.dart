const bool isProduction = bool.fromEnvironment('dart.vm.prod');

const SUB_RESSOURCE = {
  'POLICY': '/policy',
  'AGENCE': '/agence',
  'RISK': '/risk',
  'SINISTRE': '/sinistre',
  'TREATMENT': '/treatment',
  'NOTIFICATION': '/notification',
  'PARAMETRES': '/parametres',
  'VERSION': '/version-app',
  'PRODUCT': '/product',
  'USER': '/user',
  'KEYCLOAK': '/keycloak',
  'SOUSCRIPTION': '/souscription',
  'CONTRAT': '/contrat',
};

const V1 = {
  'FIND': '/v1/find',
  'FIND_ALL': '/v1/find-all',
  'FIND_USER_BY_PHONE': '/v1/get-by-realm/',
  'FIND_BY_PHONE': '/v1/find-by-phone/',
  'FIND_BY_USER_PHONE': '/v1/findByUser/',
  'UPDATE_BY_USER_ID': '/v1/update-by-user/',
  'HAS-NOT-SENT-NOTIFICATIONS': '/v1/has-not-sent-notifications/',
  'FIND_NOTIFICATION_BY_USER_ID': '/v1/find-by-user/',
  'CREATE': '/v1/create',
  'CREATE_USER': '/v1/create/',
  'FIND_BY_TYPE': '/find/all/by-type-code/',
  'UPDATE_PROFILE': '/v1/update-profil/',
  'UPDATE_USER': '/v1/update-user-myrawsur/',
  'GET_PROFILE': '/v1/get-profil/',
  'OTP_REQUEST': '/v1/otp-send/',
  'OTP_VERIFY': '/v1/otp-verify/',
  'CHANGE_PASSWORD_USER': '/v1/reset-password/',
  'GET_PERS_MORAL': '/v1/find-one/',
  'GET_RISK_BY_MATRICULE': '/v1/find-by-matricule/',
  'GET_VERSION': '/v1/check-version',
  'INIT': '/v1/init',
  'DEVIS': '/v1/devis',
  'AFN': '/v1/afn',
  'AFNV': '/v1/afnv',
  'GET_STATUS': '/v1/payment-status/',
  'INIT_PAIE_ILLICOCASH': '/v1/init-paie',
  'INIT_PAIE_BIZAO_MOBILE_MONEY': '/v1/init-paie-mobilemoney',
  'INIT_PAIE_BIZAO_DEBIT_CART': '/v1/init-paie-debitcard',
  'CONFIRM_PAIE_ILLICOCASH': '/v1/confirm-paie/',
  'GET_CP': '/print/etat/',
  'GET_CERTIFICAT_SNECA': '/v1/sneca/',
  'GET_AGENCES': '/v1/find-all',
  'DOWNLOAD_CERTIFICAT_SNECA': '/v1/downlaodsneca/',
  'GET_PROJECT_BY_PHONE_AND_CODECATE': '/v1/find-all-by-phone/',
  'GET_CONDITIONS_SOUSCRIPTION': '/v1/conditionsouscription'
};

// environement.API['URL_BASE_KEYCLOAK_API'] +
//           environement.API['SUB_RESSOURCE']['SOUSCRIPTION'] +
//           environement.API['V1']['GET_CP'] +

class Env {
  final String MODE;
  final Map<String, String> KEYCLOAK;
  final Map<String, dynamic> API;
  const Env({
    required this.MODE,
    required this.KEYCLOAK,
    required this.API,
  });
}

final Env envDev = new Env(
  MODE: 'Development',
  KEYCLOAK: {
    'KEYCLOAK_URL': 'http://192.168.88.82:8180',
    'SSO_URL': '/auth/realms/rawsur-test/protocol/openid-connect/token',
    // 'CLIENT_ID': 'transport-frontend'
    'CLIENT_ID': 'myrawsur',
    'REALM': 'rawsur-test',
  },
  API: {
    'URL_BASE': 'http://192.168.88.162:9001/api/amcassur',
    // 'URL_BASE_CORPORATE': 'http://192.168.88.163:9008/api/v1/corporate',
    'URL_BASE_KEYCLOAK_API': 'http://192.168.88.162:9006/api/keycloak',
    'SUB_RESSOURCE': SUB_RESSOURCE,
    'V1': V1,
  },
);

final Env envProd = new Env(
  MODE: 'Production',
  KEYCLOAK: {
    'KEYCLOAK_URL': 'https://auth.rawsur.com',
    // 'KEYCLOAK_URL': 'http://192.168.88.82:8180',
    'SSO_URL': '/auth/realms/rawsur/protocol/openid-connect/token',
    // 'CLIENT_ID': 'transport-frontend'
    'CLIENT_ID': 'myrawsur',
    'REALM': 'rawsur',
  },
  API: {
    'URL_BASE': 'https://mobile.rawsur.com/api/mobile',
    'URL_BASE_KEYCLOAK_API': 'https://transport.rawsur.com/api/keycloak',
    // 'URL_BASE_CORPORATE': 'https://mobile.rawsur.com/api/v1/corporate',
    'SUB_RESSOURCE': SUB_RESSOURCE,
    'V1': V1,
  },
);

final Env envTest = new Env(
  MODE: 'Production',
  KEYCLOAK: {
    'KEYCLOAK_URL': 'https://auth.rawsur.com',
    // 'KEYCLOAK_URL': 'http://192.168.88.82:8180',
    'SSO_URL': '/auth/realms/rawsur-test/protocol/openid-connect/token',
    // 'CLIENT_ID': 'transport-frontend'
    'CLIENT_ID': 'myrawsur',
    'REALM': 'rawsur-test',
  },
  API: {
    'URL_BASE': 'https://mobile-test.rawsur.com/api/mobile',
    'URL_BASE_KEYCLOAK_API': 'https://transport.rawsur.com/api/keycloak',
    // 'URL_BASE_CORPORATE': 'https://mobile.rawsur.com/api/v1/corporate',
    'SUB_RESSOURCE': SUB_RESSOURCE,
    'V1': V1,
  },
);

final Env environement = envDev;
// final Env environement = envTest;
// final Env environement = envProd;
