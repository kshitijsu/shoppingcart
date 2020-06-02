import 'package:flutter/material.dart';

import 'screens/HomeScreen.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping Cart',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: HomeScreen(),
      ),
    );
