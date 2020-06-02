import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SelectSize extends StatefulWidget {
  @override
  _SelectSizeState createState() => _SelectSizeState();
}

class _SelectSizeState extends State<SelectSize> {
  String _size = 'XS';
  String itemSize;
  String itemName;

  void getItemSize(String itemSize) {
    this.itemSize = itemSize;
  }

  void getItemName(String itemName) {
    this.itemName = itemName;
  }

  createData() {
    print('Size Added');
    DocumentReference itemSizeReference =
        Firestore.instance.collection('Item Data').document(itemName);

    Map<String, dynamic> items = {
      "Item Name": itemName,
      "Item Size": itemSize,
    };

    itemSizeReference.setData(items).whenComplete(() => {
          print('$itemSize created'),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // Text('Select Size'),
          DropdownButton<String>(
            value: _size,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.black),
            onChanged: (String newSize) {
              setState(
                () {
                  _size = newSize;
                  getItemSize(newSize);
                },
              );
            },
            items: <String>['XS', 'S', 'M', 'L', 'XL', 'XXL']
                .map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
          ),
          Container(
            width: 170,
            child: TextFormField(
              onChanged: (String newName) {
                setState(() {
                  getItemName(newName);
                });
              },
              decoration: InputDecoration(
                labelText: 'Item Name',
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {
              createData();
            },
            child: Text('Add'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          )
        ],
      ),
    );
  }
}
