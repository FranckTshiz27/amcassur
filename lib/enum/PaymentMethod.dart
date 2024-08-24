enum PaymentMethod {
  illicoCash,
  carteBancaire,
  airtel,
  afrimoney,
  orange,
  mpesa
}

extension PaymentMethodExtension on PaymentMethod {
  String get name {
    switch (this) {
      case PaymentMethod.illicoCash:
        return 'illicocash';
      case PaymentMethod.carteBancaire:
        return 'Carte Bancaire';
      case PaymentMethod.airtel:
        return 'Airtel';
      case PaymentMethod.afrimoney:
        return 'Afrimoney';
      case PaymentMethod.orange:
        return 'Orange';
      case PaymentMethod.mpesa:
        return 'Mpesa';
    }
  }

  static PaymentMethod? fromString(String name) {
    switch (name.toLowerCase()) {
      case 'illico cash':
        return PaymentMethod.illicoCash;
      case 'carte bancaire':
        return PaymentMethod.carteBancaire;
      case 'airtel':
        return PaymentMethod.airtel;
      case 'afrimoney':
        return PaymentMethod.afrimoney;
      case 'orange':
        return PaymentMethod.orange;
      case 'mpesa':
        return PaymentMethod.mpesa;
      default:
        return null;
    }
  }
}
