import 'package:flutter/material.dart';
import 'package:project_ppkd/view/bottom_nav.dart';
import 'package:project_ppkd/view/drawer.dart';

class DashboardAdminWidget extends StatefulWidget {
  const DashboardAdminWidget({super.key});

  @override
  State<DashboardAdminWidget> createState() => _DashboardAdminWidgetState();
}

class _DashboardAdminWidgetState extends State<DashboardAdminWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text("Dashboard Admin Page"),
    );
  }
}