import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insoftpro_sueno_erp/assets/asset.dart';
import 'package:insoftpro_sueno_erp/helpers/locale_manager.dart';
import 'package:insoftpro_sueno_erp/screens/login_widget.dart';

class ERPMainAppBar {
  static buildMainAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Image.network(
        Asset.logoMedium,
        scale: 1.8,
      ),
      elevation: 5,
      backgroundColor: Colors.black87,
      leadingWidth: 100,
      actions: [
        IconButton(
          splashColor: Colors.amber,
          icon: const Icon(Icons.logout),
          onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const LoginWidget()));
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginWidget()),
                (route) => false);
            LocaleManager prefs = LocaleManager.instance;
            prefs.clear();
          },
        ),
      ],
    );
  }
}
