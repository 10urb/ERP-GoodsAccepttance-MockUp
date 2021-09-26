import 'package:erp_mockup/environments/erp_main_app_bar.dart';
import 'package:erp_mockup/environments/erp_main_drawer.dart';
import 'package:erp_mockup/screens/goods_acceptance/expected_companies_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({Key? key}) : super(key: key);

  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  Future<String> _nameRetriever() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    return token;
  }

  @override
  void initState() {
    super.initState();
    _nameRetriever().then((e) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ERPMainAppBar.buildMainAppBar(context),
      drawer: ERPMainDrawer.buildMainDrawer(context),
      drawerEnableOpenDragGesture: true,
      drawerScrimColor: Colors.white24,
      body: buildBodyListView(context),
    );
  }

  ListView buildBodyListView(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 50,
              right: MediaQuery.of(context).size.width / 50,
              top: MediaQuery.of(context).size.height / 50),
          child: CalendarDatePicker(
            initialCalendarMode: DatePickerMode.day,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2100),
            onDateChanged: (value) {},
          ),
        ),
        const Divider(
          endIndent: 250,
          height: 100,
          indent: 250,
        ),
        const Text(
          "⭐ Favoriler",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 250,
            right: 250,
            top: 20,
          ),
          child: FloatingActionButton.extended(
              backgroundColor: Colors.amberAccent,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ExpectedCompaniesWidget()));
              },
              label: const Text("Mal Kabul")),
        )
      ],
    );
  }

  buildFloatingActionButton1() {
    return FloatingActionButton(
      heroTag: 1,
      onPressed: () {},
      splashColor: Colors.amber,
      backgroundColor: Colors.cyan,
      child: const Icon(Icons.logout),
    );
  }

  buildFloatingActionButton2() {
    return FloatingActionButton(
      heroTag: 2,
      onPressed: () {},
      splashColor: Colors.amber,
      backgroundColor: Colors.cyan,
      child: const Icon(Icons.add_to_queue_sharp),
    );
  }

  buildFloatingActionButton3() {
    return FloatingActionButton(
      heroTag: 3,
      onPressed: () {},
      splashColor: Colors.greenAccent,
      backgroundColor: Colors.amber.shade300,
      child: const Icon(Icons.kayaking),
    );
  }
}
