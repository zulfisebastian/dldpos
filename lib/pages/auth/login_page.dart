import 'package:dld/widgets/components/customInputPass.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dld/controllers/auth/login_controller.dart';
import 'package:dld/controllers/base/base_controller.dart';
import 'package:dld/widgets/components/customButton.dart';
import '../../constants/dimension.dart';
import '../../controllers/theme/theme_controller.dart';
import '../../utils/extensions.dart';
import '../../widgets/components/customInputForm.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ThemeController _theme = Get.find(tag: 'ThemeController');
  final BaseController _base = Get.find(tag: 'BaseController');
  final LoginController _login =
      Get.put(LoginController(), tag: 'LoginController');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: _theme.primary[4],
        resizeToAvoidBottomInset: false,
        body: Container(
          width: OtherExt().getWidth(context),
          height: OtherExt().getHeight(context),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top:
                    MediaQuery.of(context).viewInsets.bottom == 0.0 ? 300 : 100,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(CDimension.space16),
                      topRight: Radius.circular(CDimension.space16),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: Column(
                      spacing: 16,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        CustomInputForm(
                          textEditingController: _login.username.value,
                          title: "Username",
                          hintText: "Masukkan username",
                          errorMessage: "",
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (v) {
                            _login.checkDisabledForm();
                          },
                        ),
                        CustomInputPass(
                          controller: _login.password.value,
                          title: "Password",
                          hintText: "Masukkan Password",
                          errorMessage: "",
                          keyboardType: TextInputType.text,
                          onChanged: (v) {
                            _login.checkDisabledForm();
                          },
                        ),
                        Obx(
                          () => CustomButton(
                            "Masuk",
                            width: OtherExt().getWidth(context),
                            defaultColor: _theme.primary[4],
                            textColor: Colors.white,
                            disabled: _login.isDisabledForm.value,
                            onPressed: () {
                              _base.removeFocus(context);
                              _login.submitLogin();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).viewInsets.bottom == 0.0 ? 240 : 40,
                child: Container(
                  width: 120,
                  height: 120,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
