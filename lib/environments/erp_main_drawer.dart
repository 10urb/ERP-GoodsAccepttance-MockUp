import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:erp-mockup___erp/assets/asset.dart';
import 'package:erp-mockup___erp/screens/goods_acceptance/expected_companies_widget.dart';
import 'package:erp-mockup___erp/styles/erp_style.dart';

class ERPMainDrawer {
  static buildMainDrawer(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: Container(
        color: Colors.black87,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.black87,
              ),
              padding: const EdgeInsets.all(20),
              curve: standardEasing,
              child: Image.network(
                Asset.logoMedium,
                alignment: Alignment.topLeft,
                scale: 1.8,
              ),
              margin:
                  const EdgeInsets.only(left: 1, bottom: 10, top: 3, right: 0),
            ),
            ListTile(
                title: const Text(
                  "Mal Kabul",
                  style: ERPStyle.ERPListTileTextStyle,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ExpectedCompaniesWidget()));
                }),
          ],
        ),
      ),
    );
  }
}
