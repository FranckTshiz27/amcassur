import 'package:equatable/equatable.dart';

class Risque extends Equatable {
  final String id = DateTime.now().millisecondsSinceEpoch.toString(); //OK
  final String codeint;
  final String numpoli;
  final String cle; //OK
  final String? numearca; //OK
  final int? numave; //OK
  final String? typeave; //OK
  final DateTime? emissionDate;
  final DateTime? effectDate;
  final DateTime? issueDate;
  final int code_assure;
  final String? civilite;
  final int? coderisq;
  final String? typeVehicle;
  final String mark; //OK
  final String? model; //OK
  final String? caross; //OK
  final int? power; //OK
  final String? energy; //OK
  final dynamic dmc; //OK
  final String? usage; //OK
  final String? chassis; //OK
  final String? engineNumber; //OK
  final String? rem; //OK
  final String? codeGarantie; //OK
  final String? libGarantie; //OK
  final String? typeGarantie; //OK
  final String? observation; //OK
  // final int age;
  final String immatriculation; //OK
  final String? phone; //OK
  // final String numPermis;
  // final Policy policy;

  Risque({
    required this.cle,
    required this.codeint,
    required this.numpoli,
    this.numearca,
    this.numave,
    this.typeave,
    this.emissionDate,
    this.effectDate,
    this.issueDate,
    required this.code_assure,
    required this.mark,
    required this.usage,
    this.civilite,
    this.coderisq,
    this.model,
    this.typeVehicle,
    this.caross,
    this.power,
    this.energy,
    this.dmc,
    this.engineNumber,
    this.chassis,
    this.rem,
    this.libGarantie,
    this.codeGarantie,
    this.typeGarantie,
    this.observation,
    // required this.age,
    required this.immatriculation,
    this.phone,
    // required this.numPermis,
    // required this.policy,
  });

  @override
  List<Object?> get props => [
        // id,
        cle,
        codeint,
        numpoli,
        numearca,
        numave,
        typeave,
        emissionDate,
        effectDate,
        issueDate,
        code_assure,
        coderisq,
        mark,
        model,
        caross,
        typeVehicle,
        power,
        energy,
        dmc,
        usage,
        chassis,
        rem,
        codeGarantie,
        engineNumber,
        typeGarantie,
        libGarantie,
        observation,
        // age,
        immatriculation,
        phone,
        civilite,
        // numPermis,
        // policy
      ];

  Map<String, dynamic> toMap() => {
        // 'id': id,
        'cle': cle,
        'codeint': codeint,
        'numpoli': numpoli,
        'numearca': numearca,
        'numave': numave,
        'typeave': typeave,
        'numPolice': code_assure,
        'mark': mark,
        'model': model,
        // 'age': age,
        // 'numPermis': numPermis,
        'phone': phone,
        // 'policy': policy,
        "emissionDate": emissionDate,
        "effectDate": effectDate,
        "issueDate": issueDate,
        "civilite": civilite,
        "coderisq": coderisq,
        "typeVehicle": typeVehicle,
        "caross": caross,
        "power": power,
        "energy": energy,
        "dmc": dmc,
        "usage": usage,
        "engineNumber": engineNumber,
        "chassis": chassis,
        "rem": rem,
        "codeGarantie": codeGarantie,
        "libGarantie": libGarantie,
        "typeGarantie": typeGarantie,
        "observation": observation,
      };

  factory Risque.toRisk(Map<String, dynamic> map) {
    return Risque(
      // id: map['id'],
      codeint: map['codeint'],
      numpoli: map['numpoli'],
      code_assure: map['code_assure'],
      mark: map['mark'],
      usage: map['usage'],
      immatriculation: map['immatriculation'],
      cle: map['cle'],
      numearca: map['numearca'],
      numave: map['numave'],
      typeave: map['typeave'],
      model: map['model'],
      phone: map['phone'],
      emissionDate: DateTime.parse(map['emissionDate']),
      effectDate: DateTime.parse(map["effectDate"]),
      issueDate: DateTime.parse(map["issueDate"]),
      civilite: map["civilite"],
      coderisq: map["coderisq"],
      typeVehicle: map["typeVehicle"],
      caross: map["caross"],
      power: map["power"],
      energy: map["energy"],
      dmc: map["dmc"],
      engineNumber: map["engineNumber"],
      chassis: map["chassis"],
      rem: map["rem"],
      codeGarantie: map["codeGarantie"],
      libGarantie: map["libGarantie"],
      typeGarantie: map["typeGarantie"],
      observation: map["observation"],
    );
  }
}
