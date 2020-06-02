import 'package:flutter/material.dart';
import 'package:shoppingcart/components/ItemColor.dart';
import 'package:shoppingcart/components/ItemSize.dart';

class ItemDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Container(
              // color: Colors.redAccent,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: ItemColor(),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              // color: Colors.yellowAccent,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: ItemSize(),
              ),
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: Container(
          //     margin: EdgeInsets.all(10.0),
          //     child: RaisedButton(
          //       onPressed: () {},
          //       child: Text('Submit'),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
