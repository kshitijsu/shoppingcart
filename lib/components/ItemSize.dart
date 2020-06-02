import 'package:flutter/material.dart';

import 'package:shoppingcart/components/SelectSIze.dart';

class ItemSize extends StatefulWidget {
  @override
  _ItemSizeState createState() => _ItemSizeState();
}

class _ItemSizeState extends State<ItemSize> {
  int _count = 1;

  void _addNewSize() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _itemSize = List.generate(
      _count,
      (index) => SelectSize(),
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
                      SingleChildScrollView(
                        child: Container(
                          height: 300,
                          child: ListView(
                            children: _itemSize,
                          ),
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
              _addNewSize();
            },
            child: Text(
              'Add More Sizes',
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
