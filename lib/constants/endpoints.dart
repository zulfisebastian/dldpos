class Endpoint {
  static const String baseUrlDev = "https://api-dev.dld.cloud/api";
  static const String baseUrlProduction = "https://api.dld.cloud/api";

  static const String GOOGLE_MAP_KEY =
      "AIzaSyCN3phf4UaVNtxTB1yafvtpota5gJ7-ES4";

  static const String defaultImageUrl =
      "https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg";

  static const String login = '/auth';
  static const String register = '/registration';
  static const String profile = '/auth/profile';
  static const String verificationOTPLogin = '/auth/{ulid}/verify';
  static const String verificationOTPRegister = '/registration/{ulid}/verify';
  static const String profileRegistration = '/registration/{ulid}/profile';

  //Global
  static const String banner = '/banner';
  static const String bannerDetail = '/banner/{id}/show';
  static const String waste = '/waste-items';
  static const String image = '/file/upload/temp-transaction';
  static const String imageTerima = '/file/upload/temp';
  static const String status = '/resource/status-transactions';
  static const String typeWaste = '/resource/waste-types';

  //Adress
  static const String address = '/address';
  static const String addressStore = '/address/store';
  static const String addressUpdate = '/address/{id}/update';
  static const String addressDelete = '/address/{id}/delete';

  //Pengelola
  static const String pengelola = '/recycler-warehouses';
  static const String pengelolaDetail = '/recycler-warehouses/{id}/show';

  //Transaction
  static const String transactionCust = '/customer/transactions/store';
  static const String transactionCustList = '/customer/transactions';
  static const String transactionCustDetail =
      '/customer/transactions/{id}/show';
  static const String transactionOpt = '/operator/transactions/store';
  static const String transactionOptFinish =
      '/operator/transactions/{id}/finish';
  static const String transactionOptConfirmation =
      '/operator/transactions/{id}/confirmation';
  static const String transactionOptList = '/operator/transactions';
  static const String transactionOptDetail = '/operator/transactions/{id}/show';
  static const String transactionSummary = '/operator/summary/status';
}
