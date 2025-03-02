import 'dart:convert';

import 'package:erp_mockup/assets/asset.dart';
import 'package:erp_mockup/environments/environment.dart';
import 'package:erp_mockup/environments/erp_strings.dart';
import 'package:erp_mockup/helpers/erp_toastr.dart';
import 'package:erp_mockup/helpers/locale_manager.dart';
import 'package:erp_mockup/models/signed_in_model/signed_in_model.dart';
import 'package:erp_mockup/screens/home_screen_widget.dart';
import 'package:erp_mockup/services/login_service.dart';
import 'package:erp_mockup/styles/erp_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginWidget> {
  Future<SharedPreferences> signedInTokenSP = SharedPreferences.getInstance();

  late SignedInModel signedInModel;
  final _loginService = LoginService();
  var txtEmail = TextEditingController();
  var txtPassword = TextEditingController();
  var formKey = GlobalKey<FormState>();
  static String newToken = "";

  Future<bool> postLogin() async {
    var response =
        await _loginService.postLogin(txtEmail.text, txtPassword.text);
    if (response.statusCode == 200) {
      var json = SignedInModel.fromJson(jsonDecode(response.body));
      newToken = json.token.toString();
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', newToken);
      LocaleManager.instance.setStringValue(PreferencesKeys.TOKEN, newToken);

      return true;
    } else if (response.statusCode == 400) {
      //snackbar ile mesaj verilecek

      return false;
    } else {
      throw Exception(response.statusCode);
    }
  }

  @override
  void initState() {
    LocaleManager.prefrencesInit();
    super.initState();
  }

  void buildTextControllerCleaner() {
    // Clean up the controller when the widget is disposed.
    txtEmail.clear();
    txtPassword.clear();
  }

  String title = "_\n Stok Yönetim Paneline Hoş Geldiniz.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        bottomNavigationBar: buildBottomAppBar(context),
        body: buildCard(context));
  }

  Card buildCard(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(MediaQuery.of(context).size.width / 9),
      elevation: 200,
      shadowColor: Colors.blue.shade200,
      child: ListView(
        children: [
          Image.network(
            Asset.logoBig,
            scale: 1,
          ),
          Container(
            margin: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: MediaQuery.of(context).size.width / 40),
                  ),
                  buildDividerTop(),
                  buildDividerTop(),
                  buildEmailField(),
                  buildPasswordField(),
                  buildDividerTop(),
                  buildSubmitButton(),
                  const Divider(
                    color: Colors.white,
                    height: 150,
                  ),
                  Image.network(
                    Asset.logoSmall,
                    scale: 6.5,
                    alignment: Alignment.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  BottomAppBar buildBottomAppBar(BuildContext context) {
    return BottomAppBar(
        color: Colors.blue.shade300,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Text(
                "2021©erp-mockup",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width / 65,
                    fontStyle: FontStyle.normal,
                    color: Colors.white70),
              ),
            ],
          ),
        ));
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.blue.shade300,
      // actions: [
      // Image.network(
      //   Asset.erp-mockupLogo,
      //   scale: 6.5,
      //   alignment: Alignment.center,
      // ),
      // ],
    );
  }

  Widget buildEmailField() {
    return TextFormField(
      validator: MultiValidator([
        EmailValidator(errorText: "Mail Adresini Kontrol Ediniz"),
        RequiredValidator(errorText: ERPStrings.ZORUNLU_ALAN)
      ]),
      keyboardType: TextInputType.emailAddress,
      cursorColor: TextSelectionTheme.of(context).cursorColor,
      enableSuggestions: true,
      decoration: const InputDecoration(
        labelText: 'Kullanıcı adınızı giriniz *',
        labelStyle: TextStyle(
          color: Color(Environment.labelStyleColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(Environment.borderSideColor)),
        ),
      ),
      controller: txtEmail,
    );
  }

  buildPasswordField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      onEditingComplete: () {
        postLogin().then((value) {
          if (value) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const HomeScreenWidget()));
            buildTextControllerCleaner();
          } else {
            ERPToastr.buildToast("Giriş hatalı", Colors.red.shade400);
          }
        });
      },
      cursorColor: TextSelectionTheme.of(context).cursorColor,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      decoration: const InputDecoration(
        labelText: 'Şifrenizi giriniz *',
        labelStyle: TextStyle(
          color: Color(Environment.labelStyleColor),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(Environment.borderSideColor)),
        ),
      ),
      controller: txtPassword,
    );
  }

  Widget buildSubmitButton() {
    return ElevatedButton(
        style: ERPStyle.ERPsuccessElevatedButtonStyle,
        onPressed: () {
          postLogin().then((value) {
            if (value) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeScreenWidget()));
              buildTextControllerCleaner();
            } else {
              ERPToastr.buildToast("Giriş Bilgileri Hatalı!", Colors.red);
            }
          });
        },
        child: const Text("Giriş yap"));
  }

  Widget buildDividerTop() {
    return const Divider(
      color: Colors.transparent,
      thickness: 3,
      height: 20,
    );
  }
}
