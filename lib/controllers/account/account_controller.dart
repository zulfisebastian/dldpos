import 'package:dld/models/global/bank_model.dart';
import 'package:get/get.dart';

class BankController extends GetxController {
  final banks = <BankModel>[
    BankModel(code: "BCA", name: "Bank Central Asia"),
    BankModel(code: "BNI", name: "Bank Negara Indonesia"),
    BankModel(code: "BRI", name: "Bank Rakyat Indonesia"),
    BankModel(code: "Mandiri", name: "Bank Mandiri"),
  ].obs;

  getAccount() async {}
}
