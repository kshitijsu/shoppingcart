import 'package:flutter/material.dart';
import 'package:shoppingcart/components/SelectColor.dart';

class ItemColor extends StatefulWidget {
  @override
  _ItemColorState createState() => _ItemColorState();
}

class _ItemColorState extends State<ItemColor> {
  // Multiple Widdget
  int _count = 1;

  void _addNewColor() {
    setState(() {
      _count++;
    });
  }

  void upload() {}

  @override
  Widget build(BuildContext context) {
    List<Widget> _itemColor = List.generate(
      _count,
      (index) => SelectColor(),
    );
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraint) {
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 300,
                        child: ListView(
                          children: _itemColor,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          RaisedButton(
            color: Colors.purple,
            onPressed: () {
              _addNewColor();
            },
            child: Text(
              'Add More Colors',
              style: TextStyle(color: Colors.white),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          )
        ],
      ),
    );
  }
}
