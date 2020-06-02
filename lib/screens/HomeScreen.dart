import 'package:flutter/material.dart';
import 'package:shoppingcart/components/ItemDetails.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        title: Text('Shopping Cart'),
        centerTitle: true,
      ),
      body: ItemDetails(),
    );
  }
}
