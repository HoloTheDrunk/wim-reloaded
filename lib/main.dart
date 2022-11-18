import 'package:flutter/material.dart';
import 'package:wimr/inventory/inventory.dart';

void main() {
  runApp(const Wim());
}

class Wim extends StatelessWidget {
  const Wim({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warframe Inventory Manager',
      theme: ThemeData.dark(useMaterial3: true),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/logo.png"),
        leadingWidth: 200,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[InventoryGrid()],
        ),
      ),
    );
  }
}
