import 'package:flutter/material.dart';
import 'package:project_ppkd/view/drawer.dart';

class ProfilAdmin extends StatefulWidget {
  const ProfilAdmin({super.key});

  @override
  State<ProfilAdmin> createState() => _ProfilAdminState();
}

class _ProfilAdminState extends State<ProfilAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      body: Center(
child: Text("Profil Admin Page"),
      ),
    );
  }
}