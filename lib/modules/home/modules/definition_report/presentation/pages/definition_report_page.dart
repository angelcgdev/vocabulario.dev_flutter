import 'package:flutter/material.dart';

class DefinitionReportPage extends StatelessWidget {
  const DefinitionReportPage({super.key});
  static const path = "/home/definitionReport";
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Definition Report'),
      ),
    );
  }
}